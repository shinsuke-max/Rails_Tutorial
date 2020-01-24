require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'full_titleメソッド' do
    it { expect(full_title('')).to eq 'Ruby on Rails Tutorial Sample App' }
    it { expect(full_title('Help')).to eq 'Help | Ruby on Rails Tutorial Sample App' }
  end
end