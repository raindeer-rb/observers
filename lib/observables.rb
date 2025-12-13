# frozen_string_literal: true

require_relative 'models/observable'

module Observers
  class Observables
    class << self
      def reset
        @observables = {}
      end

      def observables
        @observables ||= {}
        @observables
      end

      def create(key:)
        observables[key] = Observable.new(key:)
        observables[key]
      end

      def observe(key:, observer:)
        observable = observables[key] || create(key:)
        observable.add_observer(observer:)
      end
    end
  end
end
