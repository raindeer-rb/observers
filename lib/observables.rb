# frozen_string_literal: true

require_relative 'models/observable'

module Observers
  class Observables
    class MissingKeyError < StandardError; end

    class << self
      def observables
        @observables ||= {}
        @observables
      end

      def fetch(key)
        observables[key] || raise(MissingKeyError, "Observable key '#{key}' not found")
      end

      def [](key)
        observables[key] || upsert(key:)
      end

      def upsert(key:)
        observables[key] = Observable.new if observables[key].nil?
        observables[key]
      end

      def reset
        @observables = {}
      end
    end
  end
end
