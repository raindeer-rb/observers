# frozen_string_literal: true

require_relative 'keys'
require_relative 'models/observer'

module Observers
  Config = Struct.new(:empty_observers_callback)

  class << self
    def [](key)
      Keys[key].observers
    end

    def included(klass)
      klass.extend Observers
    end

    def config
      @config ||= Config.new(empty_observers_callback: nil)
    end

    def configure
      yield(config)
    end
  end

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

  # Observe a key with "observe key, action: :action", or keys and their actions with "observe key => :action".
  # Ruby passes "key => :action" as keyword arguments when the key isn't a symbol, so they arrive in key_actions.
  def observe(key = nil, action: nil, **key_actions)
    key_actions = key.is_a?(Hash) ? key : { key => action } unless key.nil?
    raise ArgumentError, 'Missing key to observe' if key_actions.empty?

    key_actions.each { |each_key, each_action| Keys[each_key].observe(object: self, action: each_action) }
  end

  def trigger(key: self, action: nil, event: nil)
    Keys[key].trigger(action:, event:)
  end

  def take(key: self, action: nil, event: nil)
    Keys[key].take(action:, event:)
  end

  # TODO: Provide a "pipe/port/take" method that uses ractors to be concurrent... if supplied with immutable Data?
end
