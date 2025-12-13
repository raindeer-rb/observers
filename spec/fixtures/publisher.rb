# frozen_string_literal: true

require_relative '../../lib/observers'
require_relative 'event'

class Publisher
  extend Observers

  observable

  class << self
    def action_method
      trigger :action
    end

    def event_method
      trigger Event.new(action: :action)
    end
  end
end
