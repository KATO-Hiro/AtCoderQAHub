class Answer < ApplicationRecord
  validates :content, {presence: true, length: {maximum: 400}}
  acts_as_votable

  def user
    return User.find_by(id: self.user_id)
  end
end
