# frozen_string_literal: true

class UsersImportJob < ApplicationJob
  queue_as :default

  def perform(file_path)
    UsersImportService.call(file_path)
  end
end
