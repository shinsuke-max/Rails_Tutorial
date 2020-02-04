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

  describe "パスワード認証" do
    context "パスワードが一致しない" do
      before { user.password_confirmation = "mismatch" }
      it { is_expected.not_to be_valid }
    end
  end

  describe "authenticateメソッド" do
    before { user.save }
    let(:found_user) { User.find_by(email: user.email) }
    context "有効なパスワードの場合" do
      it "認証に成功" do
        should eq found_user.authenticate(user.password)
      end
      it { expect(found_user).to be_truthy }
      it { expect(found_user).to be_valid }
    end
    context "無効なパスワードの場合" do
      let(:incorrect) { found_user.authenticate("aaaaaa") }
      it "認証に失敗" do
        should_not eq incorrect
      end
      it { expect(incorrect).to be_falsey }
    end
  end

  describe "マイクロポスト関連" do
    before { user.save }

    let(:new_post) { create(:user_post, :today, user: user) }
    let(:old_post) { create(:user_post, :yesterday, user: user) }

    it "降順に表示されること" do
      new_post
      old_post

      expect(user.microposts.count).to eq 2
      expect(Micropost.all.count).to eq user.microposts.count
      expect(user.microposts.to_a).to eq [new_post, old_post]
    end

    it "ユーザーが削除されるとマイクロポストも削除される" do
      new_post
      old_post
      my_posts = user.microposts.to_a
      user.destroy

      expect(my_posts).not_to be_empty
      user.microposts.each do |post|
        expect(Micropost.where(id: post.id)).to be_empty
      end
    end
  end

  describe "フォロー/フォロー解除" do
    let(:following) { create_list(:other_user, 30) }

    before do
      user.save
      following.each do |u|
        user.follow(u)
        u.follow(user)
      end
    end

    describe "フォロー" do
      it "following? method" do
        following.each do |u|
          expect(user.following?(u)).to be_truthy
        end
      end
      it "other-user (follow method)" do
        following.each do |u|
          expect(user.following).to include(u)
        end
      end
      it "user (follow method)" do
        following.each do |u|
          expect(u.followers).to include(user)
        end
      end
    end

    describe "フォロー解除" do
      before do
        following.each do |u|
          user.unfollow(u)
        end
      end
      it "following? method" do
        following.each do |u|
          expect(user.following?(u)).to be_falsey
        end
      end
      it "other-user (follow method)" do
        following.each do |u|
          expect(user.reload.following).not_to include(u)
        end
      end
      it "user (follow method)" do
        following.each do |u|
          expect(u.followers).not_to include(user)
        end
      end
    end
  end

end
