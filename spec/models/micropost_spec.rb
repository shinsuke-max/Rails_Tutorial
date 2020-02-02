require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user) { create(:user) }
  subject(:my_post) { build(:user_post, user: user) }

  it "UserとMicropostは紐づいていること" do
    expect(my_post.user).to eq user
  end

  describe "validations" do
    describe "presence" do
      it { is_expected.to validate_presence_of :content }
      it { is_expected.to validate_presence_of :user_id }
    end

    describe "characters" do
      it { is_expected.to validate_length_of(:content).is_at_most(140) }
    end
  end
end
