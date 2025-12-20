# frozen_string_literal: true

require_relative 'observables'
require_relative 'models/observer'

module Observers
  def observable(key = self)
    Observables.upsert(key:)
  end

  # TODO: Unit test order.
  def observe(key, action = nil, order: Observables.observables.count)
    observer = Observer.new(observer: self, action:, order:)
    Observables.observe(key:, observer:)
  end

  def trigger(actionable, key = nil)
    Observables.trigger(actionable:, key: key || self)
  end

  # Returns the first observer with a non-nil return value.
  # One day it may use ractors and be concurrent, if we can freeze the args.
  def take(actionable, key = nil)
    Observables.take(actionable:, key: key || self)
  end
end
