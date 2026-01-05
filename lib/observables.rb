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

      def trigger(actionable:, key:)
        action, event = parse_actionable(actionable:)

        observable = observables[key]
        raise MissingObservableError, "Observable key '#{key}' not found" if observable.nil?

        observables[key].observers.each do |observer|
          observer.trigger(action:, event:)
        end

        nil # The trigger method is boring and uneventful, it fires events and if it doesn't complain then all is okay.
      end

      def take(actionable:, key:)
        action, event = parse_actionable(actionable:)

        observables[key].observers.each do |observer|
          result = observer.trigger(action:, event:)
          return result unless result.nil?
        end

        nil # This is a bad day for the take method, one of the worst.
      end

      private

      def parse_actionable(actionable:)
        action = actionable
        event = nil

        if actionable.class.ancestors.any? { |ancestor| ancestor.to_s == 'Low::Event' }
          event = actionable
          action = event.action
        end

        [action, event]
      end
    end
  end
end
