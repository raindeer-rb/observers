# frozen_string_literal: true

require_relative 'observables'
require_relative 'models/observer'

module Observers
  class << self
    def included(klass)
      klass.extend Observers
    end
  end

  # Add an observer on the observable side.
  def observers(key = self)
    Struct.new(:key) do
      def push(object, action: nil)
        Observables[key].observe(object:, action:)
      end
      alias :<< :push

      def count
        Observables[key].observers.count
      end
    end.new(key)
  end

  # Add an observer on the observer side.
  def observe(key, action: nil)
    Observables[key].observe(object: self, action:)
  end

  def trigger(key = self, action: nil, event: nil)
    Observables.fetch(key).trigger(action:, event:)
  end

  def take(key = self, action: nil, event: nil)
    Observables.fetch(key).take(action:, event:)
  end

  # TODO: Provide a "pipe/port/take" method that uses ractors to be concurrent... if supplied with immutable Data?
end

# For quick debugging, not official API.
OOO = Observers::Observables.observables unless defined?(OOO)
