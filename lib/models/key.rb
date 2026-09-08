# frozen_string_literal: true

module Observers
  class NoObserversError < StandardError; end

  class Key
    attr_reader :observers

    def initialize(key:)
      @key = key
      @observers = []
    end

    def observe(object:, action:)
      # TODO: We can observe objects directly, no need to wrap in an observer, unless need to let the object's observer override the action?
      # A future reason I can think of for keeping observer wrapper is to track whether the object has implemented certain actions/methods.
      @observers << Observer.new(object:, action:)
    end

    # @returns: The result of the last observer with a non-nil value.
    def trigger(action: nil, event: nil)
      # TODO: Breaks some tests... should it? Yes. Should it be disabled when testing? Yes.
      # raise NoObserversError, "No observers configured for #{@key}" if @observers.empty?

      last_result = nil

      per_observer_per_action(action:, event:) do |observer, action|
        result = observer.trigger(action:, event:)
        last_result = result unless result.nil?
        yield if block_given?
      end

      last_result
    end

    # @returns: The result of the first observer and the first action with a non-nil value.
    def take(action: nil, event: nil)
      # TODO: Breaks some tests... should it? Yes. Should it be disabled when testing? Yes.
      # raise NoObserversError, "No observers configured for #{@key}" if @observers.empty?

      per_observer_per_action(action:, event:) do |observer, action|
        result = observer.trigger(action:, event:)
        yield if block_given?
        return result unless result.nil?
      end

      # None of the observers returned a non-nil value.
      nil
    end

    private

    def per_observer_per_action(action:, event:)
      action ||= event&.action

      if action
        @observers.each do |observer|
          yield observer, action
        end
      elsif event&.actions
        @observers.each do |observer|
          event.actions.each do |action|
            yield observer, action
          end
        end
      else
        @observers.each do |observer|
          yield observer, :handle
        end
      end
    end
  end
end
