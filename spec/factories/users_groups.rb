# frozen_string_literal: true

FactoryBot.define do
  factory :users_group do
    association :group
    association :user
    role { UsersGroup.roles.keys.sample }
  end
end
