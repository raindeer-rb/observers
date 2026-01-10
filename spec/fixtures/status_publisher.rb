# frozen_string_literal: true

require 'low_type'
require_relative '../../lib/observers'

class StatusPublisher
  include LowType
  include Observers

  observable Status[200]

  class << self
    def trigger_action(action:)
      trigger(LowType::Status[200], action:)
    end

    def trigger_event(event:)
      trigger(LowType::Status[200], event:)
    end
  end
end
