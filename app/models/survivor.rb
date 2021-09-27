class Survivor < ApplicationRecord
  extend Enumerize

  has_one :location, dependent: :delete
  has_many :reports, dependent: :delete_all

  has_many :whistleblower_reports, class_name: 'Report',
                                   foreign_key: 'whistleblower_survivor_id'
  has_many :reported_reports, class_name: 'Report',
                              foreign_key: 'reported_survivor_id'

  validates :gender, :name, presence: true

  enumerize :gender, in: { male: 1, female: 2, other: 3 }

  accepts_nested_attributes_for :location

  def move
    return if infected

    location.presence&.shift
  end
end
