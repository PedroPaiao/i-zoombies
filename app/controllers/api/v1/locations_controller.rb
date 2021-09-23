class Api::V1::LocationsController < Api::ApiController
  before_action :set_survivor

  def update
    @location.assign_attributes(location_params)
    handle_success_response(@location.save)
  end

  private

  def set_survivor
    @location = Survivor.find_by(id: params[:id])&.location

    render_not_found_error unless @location.present?
  end

  def location_params
    params.require(:location).permit(:latitude, :longitude)
  end

  def handle_success_response(response, status = nil)
    if response
      render_success(serialize_resource(@location, LocationSerializer), status)
    else
      render_unprocessable_entity_error(@location.errors.messages)
    end
  end
end