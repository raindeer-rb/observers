# frozen_string_literal: true

require_relative '../../lib/observers'
load 'spec/fixtures/publisher.rb'

RSpec.describe Publisher do
  before do
    Observers::Observables.reset
    Object.send(:remove_const, 'Publisher')
    load 'spec/fixtures/publisher.rb'
  end

  describe '#initialize' do
    it 'creates an observable' do
      Publisher
      expect(Observers::Observables.observables.count).to eq(1)
    end
  end
end
