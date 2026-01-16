# frozen_string_literal: true

require_relative '../../lib/observers'
load 'spec/fixtures/class_publisher.rb'

RSpec.describe ClassPublisher do
  before do
    Observers::Observables.reset
    Object.send(:remove_const, 'ClassPublisher')
    load 'spec/fixtures/class_publisher.rb'
  end

  describe '.observers' do
    it 'creates an observer' do
      expect(Observers::Observables[ClassPublisher].observers.first.object).to eq(InverseSubscriber)
    end
  end
end
