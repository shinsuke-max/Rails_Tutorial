require 'rails_helper'

describe "Static pages" do

  describe 'Home' do
    before do
      visit '/'
    end

    describe "Home page" do
      it "should have the content 'Sample App'" do
        expect(page).to have_content('Sample App')
      end

      it "should have the title Home" do
        expect(page).to have_title("Ruby on Rails Tutorial Sample App")
      end

      it "タイトルが正しく表示されているか" do
        expect(page).to have_title full_title('')
      end

    end
  end

  describe "Help page" do
    it "should have the content 'Help'" do
      visit help_path
      expect(page).to have_content('Help')
    end

    it "should have the title About" do
      visit about_path
      expect(page).to have_title("Ruby on Rails Tutorial Sample App")
    end
  end

#Contact Test
  describe "Contact" do
    before do
      visit contact_path
    end

    describe "Contact page" do
      it "should have the content 'Contact'" do
        expect(page).to have_content('これはContact')
      end

      it "should have the title Contact" do
        expect(page).to have_title("Ruby on Rails Tutorial Sample App")
      end
    end
  end

end