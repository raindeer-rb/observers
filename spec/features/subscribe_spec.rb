# frozen_string_literal: true

require_relative '../../lib/observers'
load 'spec/fixtures/publisher.rb'
load 'spec/fixtures/subscriber.rb'

RSpec.describe Subscriber do
  describe '#initialize' do
    before do
      Observers::Observables.reset
      Object.send(:remove_const, 'Subscriber')
      load 'spec/fixtures/subscriber.rb'
    end

    it 'creates an observer' do
      expect(Observers::Observables.observables.values.first.observers.count).to eq(1)
    end
  end

  describe 'Observable#trigger' do
    before do
      Observers::Observables.reset

      Object.send(:remove_const, 'Publisher')
      Object.send(:remove_const, 'Subscriber')
      load 'spec/fixtures/publisher.rb'
      load 'spec/fixtures/subscriber.rb'

      allow(Subscriber).to receive(:action)
    end

    it "triggers an observer's action" do
      Publisher.trigger :action
      expect(Subscriber).to have_received(:action)
    end

    it "triggers an observer's action via method" do
      Publisher.action_method
      expect(Subscriber).to have_received(:action)
    end
  end
end
