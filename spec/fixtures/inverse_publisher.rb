# frozen_string_literal: true

require_relative '../../lib/observers'

class InverseSubscriber
  class << self
    def handle(event: nil) # rubocop:disable Lint/UnusedMethodArgument
      nil # Stubbed via test but here to show intent.
    end
  end
end

class Subscriber1 < InverseSubscriber; end
class Subscriber2 < InverseSubscriber; end
class Subscriber3 < InverseSubscriber; end

class InversePublisher
  include Observers

  observers << Subscriber1
  observers << Subscriber2
  observers << Subscriber3
end
