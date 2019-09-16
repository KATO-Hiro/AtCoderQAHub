class Answer < ApplicationRecord
  acts_as_votable

  def user
    return User.find_by(id: self.user_id)
  end
end
