require 'rails_helper'

RSpec.describe 'UsersSignup', type: :system do

  describe "signup" do
    before { visit "/signup" }
    it_behaves_like "signup-form have right css"

    context "有効な値の場合" do
      scenario "ユーザーが作成される" do
        expect {
          visit signup_path
          fill_in "Name",         with: "Test"
          fill_in "Email",        with: "testuser@example.com"
          fill_in "Password",     with: "password"
          fill_in "Confirmation", with: "password"
          click_button "Create my account"
        }.to change(User, :count).by(1)
        expect(page).to have_css("div.alert.alert-success", text: "Welcome to the Sample App!")
        expect(page).to have_current_path(user_path(User.last))
        expect(current_path).to eq user_path(User.last)
      end
    end

    context "無効な値の場合" do
      scenario "ユーザーが作成されない" do
        expect {
          visit signup_path
          fill_in "Name",         with: ""
          fill_in "Email",        with: ""
          fill_in "Password",     with: ""
          fill_in "Confirmation", with: ""
          click_button "Create my account"
        }.to change(User, :count).by(0)
        expect(page).to have_css('div.alert.alert-danger', text: "errors")
        expect(page).to have_title("Sign up")
        expect(page).to have_css("h1", text: "Sign up")
      end
    end
  end
end