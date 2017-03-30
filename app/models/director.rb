class Director < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :credits
  has_many :movies, through: :credits
end
