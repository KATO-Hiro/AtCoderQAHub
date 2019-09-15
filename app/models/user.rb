class User < ApplicationRecord
  validates :name, {presence: true, uniqueness: true}
  validates :password, {presence: true, uniqueness: true}
  acts_as_voter

  # TODO: ユーザーidから質問情報を取得できるようにする

  # TODO: ユーザーidから回答情報を取得できるようにする
end
