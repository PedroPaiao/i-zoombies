module CalculateResolverHelper
  SEARCH_TYPES = {
    longitude: 'CalculateDistances::Longitude',
    latitude: 'CalculateDistances::Latitude',
    inline: 'CalculateDistances::Inline'
  }.freeze

  def calculate_service(search_by)
    SEARCH_TYPES[search_by.to_sym]
  end

  def serialize_calculate_response(service_result, search_by)
    options = { each_serializer: Closest::LocationSerializer }
    survivors = ActiveModelSerializers::SerializableResource.new(
      service_result[:closest_array],
      options
    )

    {
      distance: "#{service_result[:distance].round(5)} Km",
      comparation_type: search_by,
      closest_locations: survivors
    }
  end
end