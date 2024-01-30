# frozen_string_literal: true

class UsersController < ApplicationController
  def index; end

  def upload
    uploaded_file = params[:file]

    if uploaded_file
      file_path = save_uploaded_file(uploaded_file)

      UsersImportJob.perform_later(file_path)
      redirect_to groups_path, notice: I18n.t('user.upload_success')
    else
      redirect_to users_path, alert: I18n.t('user.upload_file_not_selected')
    end
  end

  private

  def save_uploaded_file(uploaded_file)
    file_path = Rails.root.join('tmp', "uploaded_file_#{Time.current.to_i}_#{uploaded_file.original_filename}")
    File.binwrite(file_path, uploaded_file.read)
    file_path.to_s
  end
end
