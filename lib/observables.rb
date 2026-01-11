# frozen_string_literal: true

require_relative 'models/observable'

module Observers
  class Observables
    class MissingObservableError < StandardError; end

    class << self
      def observables
        @observables ||= {}
        @observables
      end
      alias all observables

      def upsert(key:)
        observables[key] = Observable.new(key:) if observables[key].nil?
        observables[key]
      end

      def reset
        @observables = {}
      end

      def observe(key:, observer:)
        observable = observables[key] || upsert(key:)
        observable.add_observer(observer:)
      end

      # @return: The result of the last trigger with a non-nil value.
      def trigger(key:, action:, event:)
        action = event.action if event && action.nil?
        action = :handle if action.nil?

        observable = observables[key]
        raise MissingObservableError, "Observable key '#{key}' not found" if observable.nil?

        last_result = nil

        observables[key].observers.each do |observer|
          result = observer.trigger(action:, event:)
          last_result = result unless result.nil?
        end

        last_result
      end
    end
  end
end
