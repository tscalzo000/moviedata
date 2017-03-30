class Credit < ApplicationRecord
  belongs_to :director
  belongs_to :movie
end
