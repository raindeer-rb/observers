# frozen_string_literal: true

require_relative '../fixtures/publisher'

RSpec.describe Publisher do
  subject(:publisher) { described_class }

  before do
    Observers::Observations.reset
    Object.send(:remove_const, 'Publisher')
    load 'spec/fixtures/publisher.rb'
  end

  describe '#initialize' do
    it 'instantiates a class' do
      expect { publisher }.not_to raise_error
    end

    it 'creates an observation' do
      publisher
      expect(Observers::Observations.observations.count).to eq(1)
    end
  end
end
