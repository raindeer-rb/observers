# frozen_string_literal: true

require_relative '../../lib/observers'

class Publisher
  extend Observers

  observable

  class << self
    def actionable_via_method(actionable)
      trigger actionable
    end
  end
end
