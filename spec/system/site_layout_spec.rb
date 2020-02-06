require 'rails_helper'

RSpec.describe 'site layout', type: :system do
  include_context "setup"

  context 'ルートパスにアクセス' do
    before { visit root_path }
    subject { page }
    it 'root_path, help_path, about_path が存在するか' do
      is_expected.to have_link nil, href: root_path, count: 2
      is_expected.to have_link 'Help', href: help_path
      is_expected.to have_link 'About', href: about_path
    end
  end

  context 'Micropost検索' do
    before { my_posts }
    it '結果がある場合' do
      valid_login(user)
      visit root_path
      fill_in "Micropost Search", with: "TestContent"
      click_button "Go"
      expect(page).to have_css("h3", text: "Micropost Feed")
      expect(page).to have_css("li", text: "TestContent")
      expect(page).not_to have_css("li", text: "None")
    end

    it '結果がない場合' do
      valid_login(user)
      visit root_path
      fill_in "Micropost Search", with: "テスト"
      click_button "Go"
      expect(page).to have_css("h3", text: "Micropost Feed")
      expect(page).not_to have_css("li", text: "TestContent")
    end

    it '空白で検索した場合' do
      valid_login(user)
      visit root_path
      fill_in "Micropost Search", with: ""
      click_button "Go"
      expect(page).to have_css("h3", text: "Micropost Feed")
      expect(page).to have_css("li", text: "TestContent")
    end
  end

  context 'signup_pathにアクセス' do
    before { visit signup_path }
    subject { page }
    it "'Sign up' と表示されているかつ、 titleに'Sign up'と表示" do
      is_expected.to have_content 'Sign up'
      is_expected.to have_title full_title('Sign up')
    end
  end

end