# frozen_string_literal: true

require_relative '../../lib/observers'
require_relative 'publisher'

class Subscriber
  extend Observers
end

class NilSubscriber < Subscriber
  observe Publisher

  class << self
    def action(event: nil)
      event
      nil # These return values are stubbed anyway but here they are to show intent.
    end
  end
end

class TrueSubscriber < Subscriber
  observe Publisher

  class << self
    def action(event: nil)
      event
      true # These return values are stubbed anyway but here they are to show intent.
    end
  end
end
