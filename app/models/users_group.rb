# frozen_string_literal: true

# == Schema Information
#
# Table name: users_groups
#
#  id         :bigint           not null, primary key
#  role       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_users_groups_on_group_id                       (group_id)
#  index_users_groups_on_user_id                        (user_id)
#  index_users_groups_on_user_id_and_group_id_and_role  (user_id,group_id,role) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (user_id => users.id)
#
class UsersGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :user_id, uniqueness: { scope: %i[role group_id] }

  enum role: { organizer: 0, presenter: 1, participant: 2 }
end
