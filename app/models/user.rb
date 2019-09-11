class User < ApplicationRecord
  validates :name, {presence: true, uniqueness: true}
  validates :password, {presence: true, uniqueness: true}
  act_as_voter
end
