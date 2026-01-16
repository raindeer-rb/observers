# frozen_string_literal: true

module Observers
  class Observable
    attr_reader :observers

    def initialize(key:)
      @key = key
      @observers = []
    end

    def observe(object:, action:)
      @observers << Observer.new(object:, action:)
    end

    # @returns: The result of the last trigger with a non-nil value.
    def trigger(action:, event:)
      action = event.action if event && action.nil?
      action = :handle if action.nil?

      last_result = nil

      @observers.each do |observer|
        result = observer.trigger(action:, event:)
        last_result = result unless result.nil?
      end

      last_result
    end
  end
end
