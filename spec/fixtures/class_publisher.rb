# frozen_string_literal: true

require_relative '../../lib/observers'

class ClassPublisher
  include Observers

  class << self
    def trigger_action(action:)
      trigger(action:)
    end

    def trigger_event(event:)
      trigger(event:)
    end
  end
end
