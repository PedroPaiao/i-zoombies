class SurvivorSerializer < ActiveModel::Serializer
  attributes :id, :name, :gender, :infected, :current_location

  def current_location
    return {} unless object.location.present?

    LocationSerializer.new(object.location)
  end
end