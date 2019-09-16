class User < ApplicationRecord
  validates :name, {presence: true, uniqueness: true}
  has_secure_password
  acts_as_voter

  def questions
    return Question.where(user_id: self.id)
  end

  # TODO: ユーザーidから回答情報を取得できるようにする
end
