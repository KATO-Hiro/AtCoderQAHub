require 'rails_helper'

RSpec.describe User, type: :model do
  it "ハンドル名とパスワードがあれば有効な状態である" do
    user = User.new(
      name: "hiro_hiro",
      password: "hogefoobarfu",
      atcoder_id: "",
    )

    expect(user).to be_valid
  end

  it "ハンドル名がなければ無効な状態である" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "重複したハンドル名なら無効な状態である"
  it "パスワードが12文字以上なら有効な状態である"
  it "パスワードが11文字以下なら無効な状態である"
  it "重複したパスワードがある場合は無効な状態である"
  it "重複したAtCoder IDがある場合は無効な状態である"
  it "ユーザーが投稿した質問をリストとして返す"
end
