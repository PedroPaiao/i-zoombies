class Api::V1::LocationsController < Api::ApiController
  before_action :set_survivor

  def update
    @location = @survivor.location

    if @location.blank?
      @location = Location.new(location_params.merge(survivor: @survivor))
    else
      @location.assign_attributes(location_params)
    end

    handle_success_response(@location.save)
  end

  private

  def set_survivor
    @survivor = Survivor.find_by(id: params[:id])

    render_not_found_error unless @survivor.present?
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