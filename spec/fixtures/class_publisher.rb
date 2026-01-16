# frozen_string_literal: true

require_relative '../../lib/observers'

class InverseSubscriber
  class << self
    def action(event: nil) # rubocop:disable Lint/UnusedMethodArgument
      nil # Stubbed via test but here to show intent.
    end
  end
end

class ClassPublisher
  include Observers

  observers << InverseSubscriber

  class << self
    def trigger_action(action:)
      trigger(action:)
    end

    def trigger_event(event:)
      trigger(event:)
    end
  end
end
