# frozen_string_literal: true

module Observers
  class Observer
    attr_reader :order

    def initialize(key:, order:)
      @key = key
      @order = order
    end
  end
end
