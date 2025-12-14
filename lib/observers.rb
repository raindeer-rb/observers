# frozen_string_literal: true

require_relative 'observables'
require_relative 'models/observer'

module Observers
  def observable(key = self)
    Observables.upsert(key:)
  end

  def observe(key, order: 0)
    observer = Observer.new(observer: self, order:)
    Observables.observe(key:, observer:)
  end

  def trigger(*args)
    key = self
    action = nil

    case args.count
    when 1
      action = args.first
    when 2
      key, action = args
    end

    if action.respond_to?(:action)
      event = action
      action = event.action
    end

    Observables.trigger(key:, action:, event: nil)
  end
end
