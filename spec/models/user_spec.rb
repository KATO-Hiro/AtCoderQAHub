require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーション" do
    context "有効な状態" do
      it "ハンドル名とパスワード（12文字以上）があれば有効な状態である" do
        expect(FactoryBot.build(:user)).to be_valid
      end
    end

    context "無効な状態" do
      before do
        @user = FactoryBot.build(:user)
      end

      it "ハンドル名がなければ無効な状態である" do
        @user.name = nil

        @user.valid?
        expect(@user.errors[:name]).to include("can't be blank")
      end

      it "空白スペース（1文字）のみのハンドル名は無効な状態である" do
        @user.name = " "

        @user.valid?
        expect(@user.errors[:name]).to include("can't be blank")
      end

      it "空白スペース（2文字）のみのハンドル名は無効な状態である" do
        @user.name = " " * 2

        @user.valid?
        expect(@user.errors[:name]).to include("can't be blank")
      end

      it "重複したハンドル名なら無効な状態である" do
        FactoryBot.create(
          :user,
          name:  "chokudai" ,
          password:  "hogefoobarfu" ,
          atcoder_id:  ""
        )

        @user.name = "chokudai"
        @user.password = "hogehogehoge"

        @user.valid?
        expect(@user.errors[:name]).to include("has already been taken")
      end

      it "パスワードがなければ無効な状態である" do
        @user.password = nil

        @user.valid?
        expect(@user.errors[:password]).to include("can't be blank")
      end


      it "空白のパスワードは無効な状態である" do
        @user.password = " " * 12

        @user.valid?
        expect(@user).to_not be_valid
      end

      it "パスワードが11文字以下なら無効な状態である" do
        @user.name = "chokudai"
        @user.password = "a" * 11

        expect(@user).to_not be_valid
      end

      pending "重複したパスワードがある場合は無効な状態である" do
        FactoryBot.create(
          :user,
          name: "takahashi",
          password: "takoyaki_daisuki",
          password_confirmation: "takoyaki_daisuki",
          atcoder_id: "",
        )

        @user.name = "aoki"
        @user.password = "takoyaki_daisuki"
        @user.password_confirmation = "takoyaki_daisuki"

        expect(@user.errors[:password_confirmation]).to include("has already been taken")
      end

      it "重複したAtCoder IDがある場合は無効な状態である" do
        FactoryBot.create(
          :user,
          name: "chokudai",
          password: "hogefoobarfu",
          atcoder_id: "chokudai",
        )

        @user.name = "aoki"
        @user.password = "hogehogehoge"
        @user.atcoder_id = "chokudai"

        @user.valid?
        expect(@user.errors[:atcoder_id]).to include("has already been taken")
      end

      it "AtCoder IDがAtCoderに登録されていない場合は無効な状態である"
    end
  end

  describe "ユーザーに紐付いた質問情報を取得する" do
    it "ユーザーが投稿した質問をリストとして返す"
  end
end
