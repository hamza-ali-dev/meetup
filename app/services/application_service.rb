# frozen_string_literal: true

class ApplicationService
  class << self
    def call(*args, **kwargs, &block)
      service = new(*args, **kwargs, &block)
      service.call
      service
    end
  end

  attr_reader :result

  def call; end

  def success?
    errors.empty?
  end

  def errors
    @errors ||= []
  end
end
