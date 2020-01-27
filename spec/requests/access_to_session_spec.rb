require 'rails_helper'

RSpec.describe 'access to sessions', type: :request do
  describe "GET #new" do
    it 'ログイン画面の表示に成功すること' do
      get login_path
      expect(response).to have_http_status(200)
    end
  end

  let!(:user) { create(:user) }
  describe 'POST #creaet' do
    it 'ログイン成功かつ正しくredirectされているか確認' do
      post login_path, params: { session: { email: user.email, 
                                  password: user.password } }
      expect(response).to redirect_to user_path(user)
      expect(is_logged_in?).to be_truthy
    end
  end
  
end