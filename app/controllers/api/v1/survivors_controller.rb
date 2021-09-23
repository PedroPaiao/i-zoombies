class Api::V1::SurvivorsController < Api::ApiController
  before_action :set_survivor, only: %i[show update destroy]

  def index
    @survivors = Survivor.all

    render json: @survivors
  end

  def show
    render json: @survivor
  end

  def create
    @survivor = Survivor.new(survivor_params)

    if @survivor.save
      render json: @survivor
    else
      render_unprocessable_entity_error(@survivor.errors.messages)
    end
  end

  def update
    @survivor.assign_attributes(survivor_params)

    if @survivor.save
      render_success
    else
      render_unprocessable_entity_error @survivor.errors.messages
    end
  end

  def destroy
    if @survivor.delete
      render_success
    else
      render_unprocessable_entity_error @survivor.errors.messages
    end
  end

  private

  def set_survivor
    @survivor = Survivor.find_by(id: params[:id])
  end

  def survivor_params
    params.require(:survivor).permit(:name, :gender)
  end
end