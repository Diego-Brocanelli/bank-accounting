class Account < ApplicationRecord
  validates :user_name, presence: true, length: { minimum: 1, maximum: 255 } 
  validates :number, presence: true, uniqueness: true, length: { minimum: 5, maximum: 15 } 
end