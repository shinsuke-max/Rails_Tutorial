require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }
  it { is_expected.to be_valid }

  describe "validations" do
    describe "presence" do
      it { is_expected.to validate_presence_of :name }
      it { is_expected.to validate_presence_of :email }

      context "パスワード、パスワード確認の一致" do
        before { user.password = user.password_confirmation = " " }
      end
    end

    describe "characters" do
      it { is_expected.to validate_length_of(:name).is_at_most(50) }
      it { is_expected.to validate_length_of(:email).is_at_most(255) }
      it { is_expected.to validate_length_of(:password).is_at_least(6) }
    end

    describe "emailフォーマット" do
      context "無効な値の場合" do
        it "失敗すること" do
          invalid_addr = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
          invalid_addr.each do |addr|
            user.email = addr
            expect(user).not_to be_valid
          end
        end
      end

      context "有効な値の場合" do
        it "成功すること" do
          valid_addr = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
          valid_addr.each do |addr|
            user.email = addr
            expect(user).to be_valid
          end
        end
      end
    end

    describe "emailの一意性" do
      context "重複した値の場合" do
        it "失敗する" do
          user = User.create(name: "test", email: "foo@bar.com", password: "password")
          dup_user = User.new(name: user.name, email: user.email.upcase, password: user.password)
          expect(dup_user).not_to be_valid
          expect(dup_user.errors[:email]).to include("has already been taken")
        end
      end

      context "大文字小文字が混在する場合" do
        let(:mix_case_email) { "Foo@ExAmPle.com" }
        it "小文字に変換されて保存されること" do
          user.email = mix_case_email
          user.save
          expect(user.reload.email).to eq mix_case_email.downcase
        end
      end
    end
  end

end
