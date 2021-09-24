class CalculateDistance < ::BaseService
  needs :survivor
  needs :search_by

  steps :fetch_variables,
        :fetch_search_by_service,
        :run_service,
        :verify_errors,
        :serialize_response

  def call
    process_steps
    @closest_survivor
  end

  private

  def fetch_variables
    @survivor = survivor
    @search_by = search_by
  end

  def fetch_search_by_service
    @service = case @search_by
               when 'longitude'
                 'CalculateDistances::Longitude'
               when 'latitude'
                 'CalculateDistances::Latitude'
               else
                 fail('Not service found error')
               end
  end

  def run_service
    @service_response = @service.constantize.call(survivor: @survivor)
  end

  def verify_errors
    return fail(@service_response.error) unless @service_response.success?

    @service_result = @service_response.result
  end

  def serialize_response
    options = { each_serializer: Closest::LocationSerializer }
    survivors = ActiveModelSerializers::SerializableResource.new(
      @service_result[:closest_array],
      options
    )

    @closest_survivor = {
      distance: @service_result[:distance],
      comparation_type: @search_by,
      closest: survivors
    }
  end
end