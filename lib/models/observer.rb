# frozen_string_literal: true

module Observers
  class Observer
    attr_reader :order

    def initialize(observer:, action:, order:)
      @observer = observer
      @action = action
      @order = order
    end

    def trigger(action:, event:)
      action = @action if @action
      event ? @observer.send(action, **{ event: event }) : @observer.send(action)
    rescue ArgumentError
      type = @observer.instance_of?(Class) ? @observer : @observer.class
      raise ArgumentError, "#{event.class} sent to #{type}##{action} but it has no 'event:' keyword argument"
    end
  end
end
