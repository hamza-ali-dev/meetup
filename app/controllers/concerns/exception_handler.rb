# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :handle_standard_error
    rescue_from ActionController::ParameterMissing, with: :render_parameter_missing
    rescue_from ActionController::InvalidAuthenticityToken, with: :invalid_csrf_token
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique
  end

  private

  def invalid_csrf_token
    message = I18n.t('errors.failed_request_authenticity')

    respond_to_error(message)
  end

  def render_error
    message = I18n.t('errors.page_not_found')

    respond_to_error(message)
  end

  def record_not_found
    message = I18n.t('errors.records_not_found')

    respond_to_error(message)
  end

  def record_not_unique
    message = I18n.t('errors.duplicate')

    respond_to_error(message)
  end

  def render_parameter_missing(exception)
    message = I18n.t('errors.missing_param', param: exception.param.to_s)

    log_exception_backtrace(exception)
    respond_to_error(message)
  end

  def handle_standard_error(exception)
    message = exception.message || I18n.t('errors.server')

    log_exception_backtrace(exception)
    respond_to_error(message)
  end

  def user_not_authorized
    message = I18n.t('errors.unauthorize')

    respond_to_error(message)
  end

  def log_exception_backtrace(exception)
    return unless Rails.env.production?

    exception.backtrace.each { |line| Rails.logger.warn(line) }
  end

  def referer_or_root_path
    redirect_back_or_to root_path
  end

  def respond_to_error(message)
    respond_to do |format|
      format.html do
        flash.alert = message

        referer_or_root_path
      end

      format.turbo_stream do
        flash.now.alert = message

        render turbo_stream: [turbo_stream.replace(:messages, partial: 'shared/messages')]
      end
    end
  end
end
