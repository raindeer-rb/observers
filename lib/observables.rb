# frozen_string_literal: true

require_relative 'models/observable'

module Observers
  class Observables
    class << self
      def observables
        @observables ||= {}
        @observables
      end

      def reset
        @observables = {}
      end

      def upsert(key:)
        observables[key] = Observable.new(key:) if observables[key].nil?
        observables[key]
      end

      def observe(key:, observer:)
        observable = observables[key] || upsert(key:)
        observable.add_observer(observer:)
      end

      def trigger(*args, key:)
        key, action, event = parse_args(*args, key:)

        observables[key].observers.each do |observer|
          observer.trigger(action:, event:)
        end

        nil # The trigger method is boring and uneventful, it fires events and if it doesn't complain then all is okay.
      end

      def take(*args, key:)
        key, action, event = parse_args(*args, key:)

        observables[key].observers.each do |observer|
          result = observer.trigger(action:, event:)
          return result unless result.nil?
        end

        nil # This is a bad day for the take method, one of the worst.
      end

      private

      def parse_args(*args, key:)
        action = nil
        event = nil

        case args.count
        when 1
          action = args.first
        when 2
          key, action = args
        end

        if action.respond_to?(:action)
          event = action
          action = event.action
        end

        [key, action, event]
      end
    end
  end
end
