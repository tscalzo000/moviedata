class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :original_title, presence: true

  has_many :credits
  has_many :directors, through: :credits
end
