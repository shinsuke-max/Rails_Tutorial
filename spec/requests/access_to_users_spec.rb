require 'rails_helper'

RSpec.describe 'access to users', type: :request do
  include_context "setup"

  describe "GET #index" do
    context "ログイン済みのユーザーとして" do
      it "正しく表示されているか" do
        sign_in_as user
        get users_path
        expect(response).to be_success
        expect(response).to have_http_status 200
      end
    end

    context "ログインしていないユーザーの場合" do
      it "ログイン画面にリダイレクトすること" do
        get users_path
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'GET #show' do
    context "ログイン済みのユーザーとして" do
      it 'responds successfully' do
        sign_in_as user
        get user_path(user)
        expect(response).to be_success
        expect(response).to have_http_status 200
      end
    end

    context "ログインしていないユーザーの場合" do
      it "ログイン画面にリダイレクトすること" do
        get user_path(user)
        expect(response).to redirect_to login_path
      end
    end
  end


  describe 'GET #new' do
    it 'responds successfully' do
      get signup_path
      expect(response).to have_http_status 200
    end
  end

  describe 'POST #create' do
    context 'valid request' do
      it 'adds a user' do
        expect do
          post signup_path, params: { user: attributes_for(:user) }
        end.to change(User, :count).by(1)
      end

      context 'adds a user' do
        before { post signup_path, params: { user: attributes_for(:user) } }
        subject { response }
        it { is_expected.to redirect_to user_path(User.last) }
        it { is_expected.to have_http_status 302 }
        it 'ユーザー作成後にログインしているか' do
          expect(is_logged_in?).to be_truthy
        end
      end
    end

    context 'invalid request' do
      let(:user_params) do
        attributes_for(:user, name: '',
                              email: 'user@invalid',
                              password: '',
                              password_confirmation: '')
      end

      it 'does not add a user' do
        expect do
          post signup_path, params: { user: user_params }
        end.to change(User, :count).by(0)
      end
    end
  end

  describe "GET #edit" do
    context "ログインユーザー済みのユーザーとして" do
      it "responds successfully" do
        sign_in_as user
        get edit_user_path(user)
        expect(response).to be_success
        expect(response).to have_http_status 200
      end
    end

    context "ログインしていない場合" do
      it "ログイン画面にリダイレクト" do
        get edit_user_path(user)
        expect(response).to have_http_status 302
        expect(response).to redirect_to login_path
      end
    end

    context "異なるユーザーの場合" do
      it "ホーム画面にリダイレクトすること" do
        sign_in_as user
        get edit_user_path(admin)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "#update" do
    context "認可されたユーザーとして" do
      it "ユーザーを更新できること" do
        user_params = FactoryBot.attributes_for(:user, name: "TestName")
        sign_in_as user
        patch user_path(user), params: { id: user.id, user: user_params }
        expect(user.reload.name).to eq "TestName"
      end
    end

    context "ログインしていない場合" do
      it "ログイン画面にリダイレクト" do
        user_params = FactoryBot.attributes_for(:user, name: "TestName")
        patch user_path(user), params: { id: user.id, user: user_params }
        expect(response).to have_http_status 302
        expect(response).to redirect_to login_path
      end
    end

    context "異なるユーザーの場合" do
      it "ユーザーを更新できないこと" do
        user_params = FactoryBot.attributes_for(:user, name: "testname")
        sign_in_as admin
        patch user_path(user), params: { id: user.id, user: user_params }
        expect(user.reload.name).to eq user.name
      end

      it "ホーム画面にリダイレクトすること" do
        user_params = FactoryBot.attributes_for(:user, name: "testname")
        sign_in_as admin
        patch user_path(user), params: { id: user.id, user: user_params }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "#destroy" do
    #context "Adminユーザーとして" do
      #it "ユーザーを削除できること" do
        #sign_in_as admin
        #expect {
          #delete user_path(user), params: { id: user.id } 
        #}.to change(User, :count).by(-1)
      #end
    #end

    context "Adminユーザーでない場合" do
      it "ホーム画面にリダイレクトすること" do
        sign_in_as user
        delete user_path(user), params: { id: user.id }
        expect(response).to redirect_to root_path
      end
    end

    context "ログインせずに削除" do
      it "return a 302 response" do
        delete user_path(user), params: { id: user.id }
        expect(response).to have_http_status 302
      end

      it "ログインページにリダイレクト" do
        delete user_path(user), params: { id: user.id }
        expect(response).to redirect_to login_path
      end
    end
  end
  
end