class Survivor < ApplicationRecord
  extend Enumerize

  validates :gender, :name, presence: true

  enumerize :gender, in: { male: 1, female: 2, other: 3 }
end
