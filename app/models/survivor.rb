class Survivor < ApplicationRecord
  extend Enumerize

  has_one :location, dependent: :delete

  validates :gender, :name, presence: true

  enumerize :gender, in: { male: 1, female: 2, other: 3 }

  accepts_nested_attributes_for :location
end
