# frozen_string_literal: true

module Low
  class Event
    attr_reader :action

    def initialize(action: :handle)
      @action = action
    end
  end
end

LowEvent = Low::Event
