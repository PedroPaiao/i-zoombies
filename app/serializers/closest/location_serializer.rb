class Closest::LocationSerializer < ActiveModel::Serializer
  attributes :id, :longitude, :latitude, :survivor

  def survivor
    Closest::SurvivorSerializer.new(object.survivor)
  end
end