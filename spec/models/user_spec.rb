# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:users_groups).dependent(:destroy) }
    it { is_expected.to have_many(:groups).through(:users_groups) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  describe '#full_name' do
    it 'returns the full name' do
      user = build(:user, first_name: 'Test', last_name: 'User')
      expect(user.full_name).to eq('Test User')
    end
  end
end
