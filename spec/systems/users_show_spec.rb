require 'rails_helper'

RSpec.describe 'UsersShow', type: :system do
  include_context "setup"

  subject { page }

  describe "show" do
    before { valid_login(user) }

    scenario "have title" do
      expect(page).to have_title(user.name)
      expect(page).to have_css("h1", text: user.name)
    end

    scenario "パスが正しいこと" do
      expect(page).to have_current_path(user_path(user))
      expect(current_path).to eq user_path(user)
    end

    describe "ユーザー情報" do
      before { my_posts }
      it { expect(user.microposts.count).to eq my_posts.count }
      it { expect(page).to have_css('img.gravatar') }
      it { expect(page).to have_css('h1', text: user.name) }
      #it { expect(page).to have_text("Microposts") }
      #it { expect(page).to have_link("view my profile", href: user_path(user)) }
    end

    describe "マイクロポスト統計" do
      before do
        my_posts
      end

      it { expect(user.microposts.count).to eq my_posts.count }
    end

    describe "マイクロポスト" do
      before { my_posts }
      it { expect(user.microposts.count).to eq my_posts.count }

      scenario "マイクロポストが表示されること" do
        expect {
          user.microposts.each do |micropost|
            expect(page).to have_link("img.gravatar", href: micropost.user)
            expect(page).to have_link("#{micropost.user.name}", href: micropost.user)
          end
        }
      end
    end
  end

end