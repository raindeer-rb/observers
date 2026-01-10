# frozen_string_literal: true

require_relative '../../lib/observers'
require_relative '../fixtures/status_publisher'

RSpec.describe 'StatusPublisher' do
  before do
    Observers::Observables.reset
    Object.send(:remove_const, 'StatusPublisher') unless defined?(StatusPublisher)
    load 'spec/fixtures/status_publisher.rb'
  end

  describe '#initialize' do
    it 'creates an observable' do
      expect(Observers::Observables.observables.count).to eq(1)
    end
  end
end
