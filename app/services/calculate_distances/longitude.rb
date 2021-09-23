class CalculateDistances::Longitude < ::BaseService
  needs :survivor

  steps :fetch_survivor

  def call
    process_steps
    @closest_survivor
  end

  private

  def fetch_survivor
    @closest_survivor = survivor
  end
end