# frozen_string_literal: true

require_relative 'models/key'

module Observers
  class Keys
    class << self
      def [](key)
        keys[key] ||= Key.new(key:)
      end

      def keys
        @keys ||= {}
        @keys
      end

      def reset
        @keys = {}
      end
    end
  end
end
