# frozen_string_literal: true

module Observers
  class Key
    attr_reader :observers

    def initialize
      @observers = []
    end

    def observe(object:, action:)
      # TODO: We can observe objects directly, no need to wrap in an observer... no need to let the object's observer override the action?
      # A future reason I can think of for keeping observer wrapper is to track whether the object has implemented certain actions/methods.
      @observers << Observer.new(object:, action:)
    end

    # @returns: The result of the last observer with a non-nil value.
    def trigger(action: nil, event:)
      action = event.action if event && action.nil?
      action = :handle if action.nil?

      last_result = nil

      @observers.each do |observer|
        result = observer.trigger(action:, event:)
        last_result = result unless result.nil?
        yield if block_given?
      end

      last_result
    end

    # @returns: The result of the first observer with a non-nil value.
    def take(action: nil, event:)
      action = event.action if event && action.nil?
      action = :handle if action.nil?

      @observers.each do |observer|
        result = observer.trigger(action:, event:)
        yield if block_given?
        return result unless result.nil?
      end

      nil # This is a bad day for the take method, one of the worst.
    end
  end
end
