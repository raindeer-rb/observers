# frozen_string_literal: true

require_relative '../fixtures/observable'

RSpec.describe Observable do
  before do
    Observers::Observations.reset
    Object.send(:remove_const, 'Observable')
    load 'spec/fixtures/observable.rb'
  end

  describe '#initialize' do
    it 'instantiates a class' do
      expect { Observable }.not_to raise_error
    end

    it 'creates an observation' do
      Observable
      expect(Observers::Observations.observations.count).to eq(1)
    end
  end
end
