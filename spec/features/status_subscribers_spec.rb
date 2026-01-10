# frozen_string_literal: true

require 'low_type'

require_relative '../../lib/observers'
require_relative '../fixtures/low_event'
require_relative '../fixtures/status_publisher'
require_relative '../fixtures/status_subscriber'

RSpec.describe 'StatusSubscriber' do
  before do
    Observers::Observables.reset

    Object.send(:remove_const, 'StatusPublisher') unless defined?(StatusPublisher)
    Object.send(:remove_const, 'StatusSubcriber') unless defined?(StatusSubscriber)

    load 'spec/fixtures/status_publisher.rb'
    load 'spec/fixtures/status_subscriber.rb'
  end

  describe 'Observables#observables' do
    it 'creates an observer' do
      expect(Observers::Observables.observables[LowType::Status[200]].observers.count).to eq(1)
    end
  end

  describe 'Observers#trigger' do
    context 'with action' do
      let(:action) { :action }

      before do
        allow(StatusSubscriber).to receive(:action)
      end

      it "triggers an observer's action" do
        StatusPublisher.trigger(LowType::Status[200], action:)
        expect(StatusSubscriber).to have_received(:action)
      end

      it "triggers an observer's action via method" do
        StatusPublisher.trigger_action(action:)
        expect(StatusSubscriber).to have_received(:action)
      end
    end

    context 'with event' do
      let(:event) { LowEvent.new(action: :action) }

      before do
        allow(StatusSubscriber).to receive(:action).with(event:)
      end

      it "triggers an observer's action" do
        StatusPublisher.trigger(LowType::Status[200], event:)
        expect(StatusSubscriber).to have_received(:action)
      end

      it "triggers an observer's action via method" do
        StatusPublisher.trigger_event(event:)
        expect(StatusSubscriber).to have_received(:action)
      end
    end
  end
end
