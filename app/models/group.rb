# frozen_string_literal: true

# == Schema Information
#
# Table name: groups
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_groups_on_name  (name) UNIQUE
#
class Group < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :users_groups, dependent: :destroy
  has_many :users, through: :users_groups

  has_many :organizers_groups, -> { organizer }, class_name: 'UsersGroup', dependent: :destroy, inverse_of: :group
  has_many :organizers, through: :organizers_groups, source: :user, class_name: 'User'

  def organizers_names
    organizers.map(&:full_name)
  end
end
