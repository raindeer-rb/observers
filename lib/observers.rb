# frozen_string_literal: true

require_relative '../observation_deck'

module Observers
  def observable(observable = nil)
    observable = self if observable.nil?
    ObservationDeck.track(observable:)
  end

  def observe(observable)
    ObservationDeck.observe(observable:, observer: self)
  end
end
