class Api::V1::LocationsController < Api::ApiController
  helper CalculateResolverHelper

  before_action :set_survivor

  def update
    @location = @survivor.location

    if @location.present?
      @location.assign_attributes(location_params)
    else
      @location = Location.new(location_params.merge(survivor_id: @survivor[:id]))
    end

    handle_success_response(@location.save)
  end

  def retrieve_closest_survivor
    service = helpers.calculate_service(location_search_params)

    if service.present?
      response = service.constantize.call(survivor: @survivor)
      handle_service_response(response)
    else
      render_not_found_error
    end
  end

  private

  def set_survivor
    @survivor = Survivor.find_by(id: params[:id])

    render_not_found_error unless @survivor.present?
  end

  def location_params
    params.require(:location).permit(:latitude, :longitude)
  end

  def location_search_params
    params.require(:search_by)
  end

  def handle_success_response(response, status = nil)
    if response
      render_success(serialize_resource(@location, LocationSerializer), status)
    else
      render_unprocessable_entity_error(@location.errors.messages)
    end
  end

  def handle_service_response(response)
    if response.success?
      render_success(helpers.serialize_calculate_response(response.result, location_search_params))
    else
      render_unprocessable_entity_error(response.error)
    end
  end
end