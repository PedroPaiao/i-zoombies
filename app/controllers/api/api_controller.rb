class Api::ApiController < ::ApplicationController
  include ApiCommonResponses
  before_action :set_meta
  around_action :switch_locale

  respond_to :json

  protected

  def serialize_resource(resource, serializer, class_name, scope: nil)
    {
      "#{class_name}": serializer.new(resource, scope: scope),
      meta: @meta
    }
  end

  def serialize_resource_list(resources, serializer, class_name)
    first_element = resources.first
    count = first_element.present? ? first_element.class.count : 0

    {
      "#{class_name}": ActiveModelSerializers::SerializableResource.new(
        resources,
        each_serializer: serializer
      ),
      meta: @meta.merge(count: count)
    }
  end

  def only_set_meta(resource)
    resource.merge(meta: @meta)
  end

  def set_meta
    @meta = {
      now: DateTime.now.to_i,
      ip: (request.present? ? request.remote_ip : nil)
    }
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale

    begin
      I18n.with_locale(locale, &action)
    rescue StandardError => e
      render json: { error: e }, status: :not_found
    end
  end
end