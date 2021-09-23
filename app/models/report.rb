class Report < ApplicationRecord
  belongs_to :whistleblower_survivor, class_name: 'Survivor'
  belongs_to :reported_survivor, class_name: 'Survivor'

  validates :whistleblower_survivor, :reported_survivor, presence: true
end
