require 'rails_helper'

RSpec.describe 'UsersEdit', type: :system do
  include_context "setup"

  subject { page }

  describe "edit" do
    context "値が有効の場合" do
      scenario "編集に成功する" do
        valid_login(user)
        click_link "Account"
        click_link "Settings"
        expect(page).to have_title("Edit user")
        expect(page).to have_css("h1", text: "Update your profile")
        expect(page).to have_link("change")
        expect {
          fill_in_update_profile_form("New Name", "new@example.com")
          click_button "Save changes"
        }.to change(User, :count).by(0)
        expect(user.reload.name).to eq "New Name"
        expect(user.reload.email).to eq "new@example.com"
        expect(page).to have_css("div.alert.alert-success", text: "Profile updated")
      end
    end

    context "値が無効な場合" do
      scenario "編集に失敗する" do
        valid_login(user)
        click_link "Account"
        click_link "Settings"
        expect {
          fill_in_update_profile_form("", "foo@ssscom")
          click_button "Save changes"
        }.to change(User, :count).by(0)
        expect(user.reload.name).not_to eq ""
        expect(user.reload.email).not_to eq "foo@ssscom"
        expect(page).to have_css('div.alert.alert-danger')
      end
    end

    #describe "adminの場合", type: :request do
      #scenario "HTTP経由で変更できないこと" do
        #patch user_path(user), params: { user: admin_params }
        #expect(user.reload).not_to be_admin
        #expect(page).to have_current_path("/")
     # end
    #end
  end
end