class Api::V1::SurvivorsController < Api::ApiController
  before_action :set_survivor, only: %i[show update destroy]

  def index
    @survivors = Survivor.all

    render_success(serialize_resource_list(@survivors, SurvivorSerializer))
  end

  def show
    handle_success_response(@survivor.present?)
  end

  def create
    @survivor = Survivor.new(survivor_params)

    handle_success_response(@survivor.save, :created)
  end

  def update
    @survivor.assign_attributes(survivor_params)

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

  def survivor_params
    params.require(:survivor).permit(:name, :gender, location_attributes: {})
  end

  def handle_success_response(response, status = nil)
    if response
      render_success(serialize_resource(@survivor, SurvivorSerializer), status)
    else
      render_unprocessable_entity_error(@survivor.errors.messages)
    end
  end
end