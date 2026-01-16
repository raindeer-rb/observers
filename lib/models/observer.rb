# frozen_string_literal: true

module Observers
  class Observer
    attr_reader :object, :action

    def initialize(object:, action:)
      @object = object
      @action = action
    end

    def trigger(action:, event:)
      action = @action if @action
      event ? @object.send(action, **{ event: }) : @object.send(action)
    rescue ArgumentError
      type = @object.instance_of?(Class) ? @object : @object.class

      raise ArgumentError, "#{type}##{action} has an 'event:' keyword argument but no event was sent" if event.nil?

      # TODO: An error here will bubble up to the observer that triggered this observer, overwriting this error with its error.
      raise ArgumentError, "#{event.class} sent to #{type}##{action} but it has no 'event:' keyword argument"
    end
  end
end
