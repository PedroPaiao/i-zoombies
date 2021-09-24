class Survivor::ShowSerializer < ActiveModel::Serializer
  attributes :id, :name, :gender, :infected, :current_location,
             :complaints_to_me, :my_complaints

  def current_location
    return {} unless object.location.present?

    LocationSerializer.new(object.location)
  end

  def complaints_to_me
    options = { each_serializer: Report::IndexSerializer, whistleblower_survivor: true }
    ActiveModelSerializers::SerializableResource.new(
      object.reported_reports,
      options
    )
  end

  def my_complaints
    options = { each_serializer: Report::IndexSerializer, reported_survivor: true }
    ActiveModelSerializers::SerializableResource.new(
      object.whistleblower_reports,
      options
    )
  end
end