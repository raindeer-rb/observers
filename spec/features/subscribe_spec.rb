# frozen_string_literal: true

require_relative '../../lib/observers'
require_relative '../fixtures/event'
require_relative '../fixtures/publisher.rb'
require_relative '../fixtures/subscriber.rb'

RSpec.describe Subscriber do
  describe 'Observables#observables' do
    before do
      Observers::Observables.reset
      Object.send(:remove_const, 'Subscriber')
      load 'spec/fixtures/subscriber.rb'
    end

    it 'creates an observer' do
      expect(Observers::Observables.observables.values.first.observers.count).to eq(1)
    end
  end

  describe 'Observers#trigger' do
    before do
      Observers::Observables.reset

      Object.send(:remove_const, 'Publisher')
      Object.send(:remove_const, 'Subscriber')
      load 'spec/fixtures/publisher.rb'
      load 'spec/fixtures/subscriber.rb'

      allow(Subscriber).to receive(:action)
    end

    context 'when the actionable is a symbol' do
      let(:actionable) { :action }

      it "triggers an observer's action" do
        Publisher.trigger actionable
        expect(Subscriber).to have_received(:action)
      end

      it "triggers an observer's action via method" do
        Publisher.actionable_via_method(actionable)
        expect(Subscriber).to have_received(:action)
      end
    end

    context 'when the actionable is an event' do
      let(:actionable) { Event.new(action: :action) }

      it "triggers an observer's action" do
        Publisher.trigger actionable
        expect(Subscriber).to have_received(:action)
      end

      it "triggers an observer's action via method" do
        Publisher.actionable_via_method(actionable)
        expect(Subscriber).to have_received(:action)
      end
    end
  end
end
