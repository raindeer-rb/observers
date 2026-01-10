# frozen_string_literal: true

require_relative '../../lib/observers'
require_relative 'class_publisher'

class ClassSubscriber
  include Observers
end

class NilSubscriber < ClassSubscriber
  observe ClassPublisher

  class << self
    def action(event: nil) # rubocop:disable Lint/UnusedMethodArgument
      nil # Stubbed via test but here to show intent.
    end
  end
end

class TrueSubscriber < ClassSubscriber
  observe ClassPublisher

  class << self
    def action(event: nil) # rubocop:disable Lint/UnusedMethodArgument
      true # Stubbed via test but here to show intent.
    end
  end
end

class ActionSubscriber < ClassSubscriber
  observe ClassPublisher, overridden_action: :my_action

  class << self
    def my_action(event: nil) # rubocop:disable Lint/UnusedMethodArgument
      nil # Stubbed via test but here to show intent.
    end
  end
end
