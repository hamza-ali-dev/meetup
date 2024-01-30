# frozen_string_literal: true

require 'csv'

class UsersImportService < ApplicationService
  EXPECTED_HEADERS = ['First Name', 'Last Name', 'Group Name', 'Role in Group'].freeze

  def initialize(file_path)
    @file_path = file_path
  end

  def call
    csv_headers = CSV.read(@file_path, headers: true).headers
    return unless csv_headers.to_set.sort == EXPECTED_HEADERS.to_set.sort

    import_users
  end

  private

  def import_users
    CSV.foreach(@file_path, headers: true) do |row|
      user_hash = row.to_hash
      first_name = user_hash['First Name']&.strip
      last_name = user_hash['Last Name']&.strip
      group_name = user_hash['Group Name']&.strip
      role = user_hash['Role in Group']&.strip&.downcase

      user = User.find_or_create_by(first_name: first_name, last_name: last_name)
      group = Group.find_or_create_by(name: group_name)

      next if user.blank?

      user.users_groups.find_or_create_by(group: group, role: role)
    end
  end
end
