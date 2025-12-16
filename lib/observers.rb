# frozen_string_literal: true

require_relative 'observables'
require_relative 'models/observer'

module Observers
  def observable(key = self)
    Observables.upsert(key:)
  end

  # TODO: Test order.
  def observe(key, order: Observables.observables.count)
    observer = Observer.new(observer: self, order:)
    Observables.observe(key:, observer:)
  end

  def trigger(*args)
    Observables.trigger(*args, key: self)
  end

  # Returns the first observer with a non-nil return value.
  # One day it may use ractors and be concurrent, if we can freeze the args.
  def take(*args)
    Observables.take(*args, key: self)
  end
end
