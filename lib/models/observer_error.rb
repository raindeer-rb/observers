# frozen_string_literal: true

module Observers
  # Map the events and actions along the way when showing an exception.
  # Any exceptions in this class itself will fail silently as they will error out into itself.
  class ObserverError < StandardError
    def initialize(message, object:, event:, action:, previous_error:)
      super(message)

      @event = event
      @object = object
      @action = action
      @previous_error = previous_error
    end

    def link
      class_type = @object.instance_of?(Class) ? @object : @object.class
      method_type = @object.instance_of?(Class) ? '.' : '#'
      "#{@event.class} -> #{class_type}#{method_type}#{@action}"
    end

    def to_s
      chain = [link]
      first_error = first_error(@previous_error, chain:)
      error_location = first_error.backtrace.first

      "#{chain.join(' -> ')} -> #{first_error.message}\n#{error_location}"
    end

    private

    def first_error(error, chain:)
      chain << error.link if error.respond_to?(:link)

      return error unless error.respond_to?(:previous_error)

      first_error(error.previous_error, chain:)
    end
  end
end
