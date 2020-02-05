require 'rails_helper'

RSpec.describe 'UsersIndex', type: :system do
  include_context "setup"

  subject { page }

  describe "index" do
    before { users }
    it { expect(User.count).to eq users.count }

    scenario "ページネーションでユーザーが表示されること" do
      valid_login(user)
      click_link "Users"
      expect(page).to have_current_path("/users")
      expect(page).to have_css("h1", text: "All users")
      User.paginate(page: 1).each do |user|
        expect(page).to have_css("li", text: user.name)
      end
    end

    context "Users Search" do
      it "検索が有効の場合(Example user)" do
        valid_login(user)
        click_link "Users"
        fill_in "User Search", with: "Example user"
        click_button "Go"
        expect(page).to have_css("h1", text: "Search Result")
        expect(page).to have_css("li", text: "Example user")
        expect(page).not_to have_css("li", text: "other_user")
      end

      it "検索が有効の場合(other_user)" do
        valid_login(user)
        click_link "Users"
        fill_in "User Search", with: "other_user"
        click_button "Go"
        expect(page).to have_css("h1", text: "Search Result")
        expect(page).to have_css("li", text: "other_user")
        expect(page).not_to have_css("li", text: "Example user")
      end

      it "検索が無効の場合" do
        valid_login(user)
        click_link "Users"
        fill_in "User Search", with: "あ"
        click_button "Go"
        expect(page).to have_css("h1", text: "Search Result")
        expect(page).to have_content("検索結果は0です。")
      end
    end
  end

end