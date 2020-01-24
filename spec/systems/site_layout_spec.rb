require 'rails_helper'

RSpec.describe 'site layout', type: :system do
  context 'ルートパスにアクセス' do
    before { visit root_path }
    subject { page }
    it 'root_path, help_path, about_path が存在するか' do
      is_expected.to have_link nil, href: root_path, count: 2
      is_expected.to have_link 'Help', href: help_path
      is_expected.to have_link 'About', href: about_path
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