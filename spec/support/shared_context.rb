RSpec.shared_context "setup" do
  #ユーザー
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user)}
  let(:admin) { FactoryBot.create(:admin) }
  let(:admin_params) { attributes_for(:user, admin: true)}
  let(:users) { create_list(:other_user, 30) }
  #マイクロポスト
  let(:my_posts) { create_list(:user_post, 30, user: user) }
  let(:other_posts) { create_list(:other_user_post, 30, user: other_user) }
end