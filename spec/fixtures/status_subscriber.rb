# frozen_string_literal: true

require 'low_type'
require_relative '../../lib/observers'

class StatusSubscriber
  include LowType
  include Observers

  observe Status[200]
end
