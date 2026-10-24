# frozen_string_literal: true

require 'lowtype'
require_relative '../../lib/observers'

class StatusSubscriber
  include LowType
  include Observers

  observe Low::Types::Status[200]
end
