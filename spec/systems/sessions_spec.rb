require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  before do
    visit login_path
  end

  describe 'ログインが無効になること' do
    before do
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      click_button 'Log in'
    end
    subject { page }

    it 'フラッシュメッセージが表示' do
      is_expected.to have_selector('.alert-danger', text: 'Invalid email/password combination')
      is_expected.to have_current_path login_path
    end

    context '違うページにアクセスした時' do
      before { visit root_path }
      it 'フラッシュメッセージが消えること' do
        is_expected.to_not have_selector('.alert-danger', text: 'Invalid email/password combination')
      end
    end
  end
end