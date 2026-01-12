# frozen_string_literal: true

module Observers
  class Observer
    attr_reader :order

    def initialize(object:, action:, order:)
      @object = object
      @action = action
      @order = order
    end

    def trigger(action:, event:)
      action = @action if @action
      event ? @object.send(action, **{ event: }) : @object.send(action)
    rescue ArgumentError => e
      type = @object.instance_of?(Class) ? @object : @object.class

      raise ArgumentError, "#{type}##{action} has an 'event:' keyword argument but no event was sent" if event.nil?

      raise ArgumentError, "#{event.class} sent to #{type}##{action} but it has no 'event:' keyword argument"
    end
  end
end
