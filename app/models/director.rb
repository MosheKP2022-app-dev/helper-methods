class Director < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :bio, presence: true
end
