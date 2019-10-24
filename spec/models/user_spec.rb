require 'rails_helper'

RSpec.describe User, type: :model do
  it "ハンドル名があれば有効な状態である"
  it "ハンドル名がなければ無効な状態である"
  it "重複したハンドル名なら無効な状態である"
  it "ユーザーが投稿した質問をリストとして返す"
end
