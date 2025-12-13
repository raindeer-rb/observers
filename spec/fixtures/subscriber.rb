# frozen_string_literal: true

require_relative '../../lib/observers'
require_relative 'publisher'

class Subscriber
  extend Observers

  observe Publisher

  class << self
    def action
      true
    end
  end
end
