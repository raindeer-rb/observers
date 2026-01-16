# frozen_string_literal: true

require_relative '../../lib/observers'
load 'spec/fixtures/inverse_publisher.rb'

RSpec.describe InversePublisher do
  before do
    Observers::Observables.reset
    Object.send(:remove_const, 'InversePublisher')
    load 'spec/fixtures/inverse_publisher.rb'
  end

  describe '.observers' do
    it 'saves observers in correct order' do
      observers = Observers::Observables.fetch(InversePublisher).observers
      expect(observers[0].object).to eq(Subscriber1)
      expect(observers[1].object).to eq(Subscriber2)
      expect(observers[2].object).to eq(Subscriber3)
    end
  end

  describe '#take' do
    context 'with action' do
      let(:action) { :handle }

      before do
        allow(Subscriber1).to receive(:handle).and_return(nil)
        allow(Subscriber2).to receive(:handle).and_return(2)
        allow(Subscriber3).to receive(:handle).and_return(3)
      end

      it 'returns the result of the first observer with a non-nil value' do
        expect(InversePublisher.take(action:)).to eq(2)
        expect(Subscriber1).to have_received(:handle)
        expect(Subscriber2).to have_received(:handle)
        expect(Subscriber3).not_to have_received(:handle)
      end
    end

    context 'with event' do
      let(:event) { LowEvent.new(action: :handle) }

      before do
        allow(Subscriber1).to receive(:handle).with(event:).and_return(nil)
        allow(Subscriber2).to receive(:handle).with(event:).and_return(2)
        allow(Subscriber3).to receive(:handle).with(event:).and_return(3)
      end

      it 'returns the result of the first observer with a non-nil value' do
        expect(InversePublisher.take(event:)).to eq(2)
        expect(Subscriber1).to have_received(:handle)
        expect(Subscriber2).to have_received(:handle)
        expect(Subscriber3).not_to have_received(:handle)
      end
    end
  end
end
