# frozen_string_literal: true

module Observers
  class Observer
    attr_reader :order

    def initialize(observer:, order:)
      @observer = observer
      @order = order
    end

    def trigger(action:, event:)
      event ? @observer.send(action, event) : @observer.send(action)
    end
  end
end
