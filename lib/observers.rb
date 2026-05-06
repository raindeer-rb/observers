# frozen_string_literal: true

require_relative 'keys'
require_relative 'models/observer'

module Observers
  class << self
    def included(klass)
      klass.extend Observers
    end

    def config
      @config ||= Config.new(key_callback: nil)
    end

    def configure
      yield(config)
    end
  end

  Config = Struct.new(:key_callback)

  def observers(key = self)
    Struct.new(:key) do
      def push(object, action: nil)
        Keys[key].observe(object:, action:)
      end
      alias :<< :push

      def count
        Keys[key].observers.count
      end
    end.new(key)
  end

  def observe(key, action: nil)
    Keys[key].observe(object: self, action:)
  end

  def trigger(key: self, action: nil, event: nil)
    Keys[key].trigger(action:, event:)
  end

  def take(key: self, action: nil, event: nil)
    Keys[key].take(action:, event:)
  end

  # TODO: Provide a "pipe/port/take" method that uses ractors to be concurrent... if supplied with immutable Data?
end

# For quick debugging, not official API.
OKK = Observers::Keys.keys unless defined?(OKK)
