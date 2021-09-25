module CalculateResolverHelper
  def calculate_service(search_by)
    case search_by
    when 'longitude'
      'CalculateDistances::Longitude'
    when 'latitude'
      'CalculateDistances::Latitude'
    end
  end

  def serialize_calculate_response(service_result, search_by)
    options = { each_serializer: Closest::LocationSerializer }
    survivors = ActiveModelSerializers::SerializableResource.new(
      service_result[:closest_array],
      options
    )

    {
      distance: service_result[:distance],
      comparation_type: search_by,
      closest: survivors
    }
  end
end