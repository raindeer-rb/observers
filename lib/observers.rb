# frozen_string_literal: true

require_relative 'observables'
require_relative 'models/observer'

module Observers
  def self.included(klass)
    klass.extend Observers
  end

  def observables
    Observables.observables
  end

  def observable(key = self)
    Observables.upsert(key:)
  end

  # TODO: Unit test order.
  def observe(key, overridden_action: nil, order: Observables.observables.count)
    observer = Observer.new(observer: self, action: overridden_action, order:)
    Observables.observe(key:, observer:)
  end

  # Returns the last observer with a non-nil return value.
  def trigger(key = self, action: nil, event: nil)
    raise ArgumentError, 'Action or event required' if action.nil? && event.nil?

    # TODO: Parsing logic can be simplified/removed now that action and event args are separated.
    Observables.trigger(actionable: action || event, key:)
  end

  # TODO: Provide a "pipe/port/take" method that uses ractors to be concurrent... if supplied with immutable Data?
end
