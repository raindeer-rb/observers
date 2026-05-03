# frozen_string_literal: true

class MockEvent
  attr_reader :action

  def initialize(action: :handle)
    @action = action
  end
end
