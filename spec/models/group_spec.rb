# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:users_groups).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:users_groups) }
    it { is_expected.to have_many(:organizers_groups).dependent(:destroy).inverse_of(:group) }
    it { is_expected.to have_many(:organizers).through(:organizers_groups).source(:user).class_name('User') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe '#organizers_names' do
    it 'returns an array of organizers full names' do
      group = create(:group)
      organizer1 = create(:user)
      organizer2 = create(:user)
      create(:users_group, group: group, user: organizer1, role: :organizer)
      create(:users_group, group: group, user: organizer2, role: :organizer)

      expect(group.organizers_names).to match_array([organizer1.full_name, organizer2.full_name])
    end

    it 'returns an empty array when there are no organizers' do
      group = create(:group)

      expect(group.organizers_names).to eq([])
    end
  end
end
