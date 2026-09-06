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

      return unless @object.respond_to?(action)

      # Assumption that if method has params then that param is "event:".
      if event && @object.method(action).parameters.count > 0
        @object.send(action, **{ event: })
      else
        @object.send(action)
      end
    rescue ArgumentError => e
      type = @object.instance_of?(Class) ? @object : @object.class
      method_type = @object.instance_of?(Class) ? '.' : '#'

      raise ArgumentError, "#{type}##{action} has an 'event:' keyword argument but no event arg was sent" if event.nil?

      # Events trigger events, so the error bubbles up to become the error message for the next rescue's error message:
      # "RequestEvent sent to Rain::Router#route_request -> StatusEvent sent to Error404Node.render -> unknown keyword: :props"
      raise ArgumentError, "#{event.class} sent to #{type}#{method_type}#{action} -> #{e.message}"
    end
  end
end
