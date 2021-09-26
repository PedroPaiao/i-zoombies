class Api::V1::SurvivorsController < Api::ApiController
  before_action :set_survivor, only: %i[show update destroy]
  CLASS_NAME = Survivor.name.underscore

  def index
    @survivors = Survivor.all
                         .order(created_at: :desc)
                         .page(params[:page] || 1)
                         .per(params[:per] || 10)

    render_success(serialize_resource_list(@survivors, Survivor::IndexSerializer, CLASS_NAME.pluralize))
  end

  def move_all_survivors
    result = Survivors::MoveAll.new.move_all
    if result.any?(false)
      render json: only_set_meta({ error: I18n.t('.suvivors_move.error') }), status: :unprocessable_entity
    else
      render json: only_set_meta({ success: I18n.t('.suvivors_move.success') }), status: :ok
    end
  end

  def show
    render_success(serialize_resource(@survivor, Survivor::ShowSerializer, CLASS_NAME))
  end

  def create
    @survivor = Survivor.new(create_survivor_params)

    handle_success_response(@survivor.save, :created)
  end

  def update
    @survivor.assign_attributes(update_suvivor_params)

    handle_success_response(@survivor.save)
  end

  def destroy
    handle_success_response(@survivor.delete)
  end

  private

  def set_survivor
    @survivor = Survivor.find_by(id: params[:id])

    render_not_found_error unless @survivor.present?
  end

  def create_survivor_params
    params.require(:survivor).permit(:name, :gender, location_attributes: {})
  end

  def update_suvivor_params
    create_survivor_params.except(:location_attributes)
  end

  def handle_success_response(response, status = nil)
    if response
      render_success(serialize_resource(@survivor, Survivor::ShowSerializer, CLASS_NAME), status)
    else
      render_unprocessable_entity_error(@survivor.errors.messages)
    end
  end
end