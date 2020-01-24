require 'rails_helper'

describe "Static pages" do

  describe 'Home' do
    it 'タイトル内容の表示' do
      visit '/'
      expect(page).to have_title 'Home | Ruby on Rails Tutorial Sample App'
    end
  end

  describe "Home page" do
    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end

    it "should have the title Home" do
      visit '/static_pages/home'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App")
    end

  end

  describe "Help page" do
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end

    it "should have the title About" do
      visit '/static_pages/about'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App")
    end

  end

end