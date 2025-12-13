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

    event = nil
    if action.is_a?(Event)
      event = action
      action = arg.action
    end

    Observables.trigger(key:, action:, event:)
  end
end
