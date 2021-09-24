class Survivor < ApplicationRecord
  extend Enumerize

  has_one :location, dependent: :delete
  has_many :reports, dependent: :delete_all

  validates :gender, :name, presence: true

  enumerize :gender, in: { male: 1, female: 2, other: 3 }

  accepts_nested_attributes_for :location
end
