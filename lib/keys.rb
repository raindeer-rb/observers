# frozen_string_literal: true

require_relative 'models/key'

module Observers
  class Keys
    class << self
      def keys
        @keys ||= {}
        @keys
      end

      def [](key)
        keys[key] ||= Key.new(key:)
      end

      def reset
        @keys = {}
      end
    end
  end
end
