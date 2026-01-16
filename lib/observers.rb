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
    ObservableProxy = Struct.new do
      def <<(object, action: nil)
        Observables[key].observe(object:, action:)
      end
    end
    ObservableProxy.new
  end

  # Add an observer on the observer side.
  def observe(key, action: nil)
    Observables[key].observe(object: self, action:)
  end

  # Returns the last observer's non-nil return value.
  def trigger(key = self, action: nil, event: nil)
    Observables.fetch(key).trigger(action:, event:)
  end

  # TODO: Provide a "pipe/port/take" method that uses ractors to be concurrent... if supplied with immutable Data?
end

# For quick debugging, not official API.
OOO = Observers::Observables.observables
