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
      event ? @observer.send(action, **{ event: }) : @observer.send(action)
    rescue ArgumentError
      type = @observer.instance_of?(Class) ? @observer : @observer.class

      if event.nil?
        raise ArgumentError, "#{type}##{action} has an 'event:' keyword argument but no event was sent"
      else
        raise ArgumentError, "#{event.class} sent to #{type}##{action} but it has no 'event:' keyword argument"
      end
    end
  end
end
