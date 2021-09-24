class ReportSerializer < ActiveModel::Serializer
  attributes :id, :description, :reported_survivor, :whistleblower_survivor

  def reported_survivor
    SurvivorSerializer.new(object.reported_survivor)
  end

  def whistleblower_survivor
    SurvivorSerializer.new(object.whistleblower_survivor)
  end
end