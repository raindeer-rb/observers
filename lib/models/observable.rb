# frozen_string_literal: true

module Observers
  class Observable
    attr_reader :observers

    def initialize(key:)
      @key = key
      @observers = []
    end

    def add_observer(observer:)
      @observers << observer
      @observers.sort_by(&:order)
    end
  end
end
