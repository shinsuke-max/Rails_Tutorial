require 'rails_helper'

RSpec.describe 'Authorization', type: :feature do
  include_context "setup"

  describe "UsersController", type: :request do
    describe "login as necessary" do
      context "when non-login" do
        describe "index" do
          subject { Proc.new { get users_path } }
          it_behaves_like "error message", "Please log in."
          it_behaves_like "redirect to path", "/login"
        end
        describe "edit" do
          subject { Proc.new { get edit_user_path(user) } }
          it_behaves_like "error message", "Please log in."
          it_behaves_like "redirect to path", "/login"
        end
        describe "update" do
          subject { Proc.new { patch user_path(user), params: { user: other_user } } }
          it_behaves_like "error message", "Please log in."
          it_behaves_like "redirect to path", "/login"
        end
        describe "destroy" do
          subject { Proc.new { delete user_path(other_user) } }
          it_behaves_like "error message", "Please log in."
          it_behaves_like "redirect to path", "/login"
        end
        describe "following" do
          subject { Proc.new { get following_user_path(user) } }
          it_behaves_like "error message", "Please log in."
          it_behaves_like "redirect to path", "/login"
        end
        describe "followers" do
          subject { Proc.new { get followers_user_path(user) } }
          it_behaves_like "error message", "Please log in."
          it_behaves_like "redirect to path", "/login"
        end
      end
    end
  end

  describe "MicropostsController", type: :request do
    context "when non-login" do
      describe "create" do
        subject { Proc.new { post microposts_path, params: post_params } }
          it_behaves_like "error message", "Please log in."
          it_behaves_like "redirect to path", "/login"
      end
      describe "destroy" do
        subject { Proc.new { delete micropost_path(my_post.id) } }
        it_behaves_like "error message", "Please log in."
        it_behaves_like "redirect to path", "/login"
      end
    end
  end
end