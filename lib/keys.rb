# frozen_string_literal: true

require_relative 'models/key'

module Observers
  class Keys
    class MissingKeyError < StandardError; end

    class << self
      def keys
        @keys ||= {}
        @keys
      end

      def fetch(key)
        # TODO: Log instead per configuration, much better to fail silently sometimes!
        keys[key] || raise(MissingKeyError, "Key key '#{key}' not found")
      end

      def [](key)
        keys[key] || upsert(key:)
      end

      def upsert(key:)
        keys[key] = Key.new if keys[key].nil?
        keys[key]
      end

      def reset
        @keys = {}
      end
    end
  end
end
