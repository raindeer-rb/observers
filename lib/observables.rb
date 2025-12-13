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

      def trigger(key:, action:, event: nil)
        observables[key].observers.each do |observer|
          observer.trigger(action:, event:)
        end
      end
    end
  end
end
