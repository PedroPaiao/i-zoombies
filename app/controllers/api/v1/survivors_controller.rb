class Api::V1::SurvivorsController < Api::ApiController
  def index
    @survivors = Survivor.all

    render json: @survivors
  end
end