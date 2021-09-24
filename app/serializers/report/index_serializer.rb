class Report::IndexSerializer < ActiveModel::Serializer
  attributes :id, :description, :reported_survivor, :whistleblower_survivor

  attribute :reported_survivor, if: :reported_suvivor?
  attribute :whistleblower_survivor, if: :whistleblower_survivor?

  def reported_survivor
    Survivor::IndexSerializer.new(object.reported_survivor)
  end

  def whistleblower_survivor
    Survivor::IndexSerializer.new(object.whistleblower_survivor)
  end

  def whistleblower_survivor?
    @instance_options[:whistleblower_survivor]
  end

  def reported_suvivor?
    @instance_options[:reported_survivor]
  end
end