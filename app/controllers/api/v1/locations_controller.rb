class Api::V1::SurvivorsController < Api::ApiController
  before_action :set_survivor

  def update
    location = @survivor.location.assign_attributes(location_params)

    handle_success_response(location)
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
      render_success(serialize_resource(@survivor, SurvivorSerializer), status)
    else
      render_unprocessable_entity_error(@survivor.errors.messages)
    end
  end
end