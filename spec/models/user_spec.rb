require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーション" do
    context "有効な状態" do
      it "ハンドル名とパスワードがあれば有効な状態である" do
        user = User.new(
          name: "hiro_hiro",
          password: "hogefoobarfu",
          password_confirmation: "hogefoobarfu",
          atcoder_id: "",
        )

        expect(user).to be_valid
      end

      it "パスワードが12文字以上なら有効な状態である" do
        user = User.new(
          name: "chokudai",
          password: "hogefoobarfu",
          atcoder_id: "",
        )

        expect(user).to be_valid
      end
    end

    context "無効な状態" do
      it "ハンドル名がなければ無効な状態である" do
        user = User.new(name: nil)
        user.valid?
        expect(user.errors[:name]).to include("can't be blank")
      end

      it "空白スペース（1文字）のみのハンドル名は無効な状態である" do
        user = User.new(name: " ")
        user.valid?
        expect(user.errors[:name]).to include("can't be blank")
      end

      it "空白スペース（2文字）のみのハンドル名は無効な状態である" do
        user = User.new(name: "  ")
        user.valid?
        expect(user.errors[:name]).to include("can't be blank")
      end

      it "重複したハンドル名なら無効な状態である" do
        User.create(
          name: "chokudai",
          password: "hogefoobarfu",
          atcoder_id: "",
        )

        user = User.new(
          name: "chokudai",
          password: "hogehogehoge",
          atcoder_id: "",
        )

        user.valid?
        expect(user.errors[:name]).to include("has already been taken")
      end

      it "パスワードがなければ無効な状態である" do
        user = User.new(password: nil)
        user.valid?
        expect(user.errors[:password]).to include("can't be blank")
      end


      it "空白のパスワードは無効な状態である" do
        user = User.new(
          password: " " * 12
        )

        user.valid?
        expect(user).to_not be_valid
      end

      it "パスワードが11文字以下なら無効な状態である" do
        user = User.new(
          name: "chokudai",
          password: "a" * 11,
          atcoder_id: "",
        )

        expect(user).to_not be_valid
      end

      pending "重複したパスワードがある場合は無効な状態である" do
        User.create(
          name: "takahashi",
          password: "takoyaki_daisuki",
          password_confirmation: "takoyaki_daisuki",
          atcoder_id: "",
        )

        user = User.new(
          name: "aoki",
          password: "takoyaki_daisuki",
          password_confirmation: "takoyaki_daisuki",
          atcoder_id: "",
        )

        expect(user.errors[:password_confirmation]).to include("has already been taken")
      end

      it "重複したAtCoder IDがある場合は無効な状態である" do
        User.create(
          name: "chokudai",
          password: "hogefoobarfu",
          atcoder_id: "chokudai",
        )

        user = User.new(
          name: "aoki",
          password: "hogehogehoge",
          atcoder_id: "chokudai",
        )

        user.valid?
        expect(user.errors[:atcoder_id]).to include("has already been taken")
      end

      it "AtCoder IDがAtCoderに登録されていない場合は無効な状態である"
    end
  end

  describe "ユーザーに紐付いた質問情報を取得する" do
    it "ユーザーが投稿した質問をリストとして返す"
  end
end
