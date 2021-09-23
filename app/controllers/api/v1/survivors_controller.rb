class Api::V1::SurvivorsController < Api::ApiController
  before_action :set_survivor, only: [:show]

  def index
    @survivors = Survivor.all

    render json: @survivors
  end

  def show
    render json: @survivor
  end

  private

  def set_survivor
    @survivor = Survivor.find_by(id: params[:id])
  end
end