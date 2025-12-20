# frozen_string_literal: true

require_relative '../../lib/observers'
require_relative 'publisher'

class Subscriber
  extend Observers
end

class NilSubscriber < Subscriber
  observe Publisher

  class << self
    def action(event: nil) # rubocop:disable Lint/UnusedMethodArgument
      nil # Stubbed via test but here to show intent.
    end
  end
end

class TrueSubscriber < Subscriber
  observe Publisher

  class << self
    def action(event: nil) # rubocop:disable Lint/UnusedMethodArgument
      true # Stubbed via test but here to show intent.
    end
  end
end

class ActionSubscriber < Subscriber
  observe Publisher, :overridden_action

  class << self
    def overridden_action(event: nil) # rubocop:disable Lint/UnusedMethodArgument
      nil # Stubbed via test but here to show intent.
    end
  end
end
