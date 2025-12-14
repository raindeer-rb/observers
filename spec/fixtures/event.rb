# frozen_string_literal: true

class Event
  attr_reader :action

  def initialize(action:)
    @action = action
  end
end
