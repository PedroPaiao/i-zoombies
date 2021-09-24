class Report::ShowSerializer < ActiveModel::Serializer
  attributes :id, :description, :reported_survivor, :whistleblower_survivor

  def reported_survivor
    Survivor::IndexSerializer.new(object.reported_survivor)
  end

  def whistleblower_survivor
    Survivor::IndexSerializer.new(object.whistleblower_survivor)
  end
end