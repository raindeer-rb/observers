# frozen_string_literal: true

require_relative 'observables'
require_relative 'models/observer'

module Observers
  def observable(key = self)
    Observables.create(key:)
  end

  def observe(key, order: 0)
    observer = Observer.new(key:, order:)
    Observables.observe(key:, observer:)
  end
end
