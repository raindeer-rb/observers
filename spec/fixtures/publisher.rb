# frozen_string_literal: true

require_relative '../../lib/observers'

class Publisher
  extend Observers
  observable

  class << self
    def trigger_via_method(actionable)
      trigger actionable
    end

    def take_via_method(actionable)
      take actionable
    end
  end
end
