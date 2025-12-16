# frozen_string_literal: true

require_relative '../../lib/observers'
require_relative '../fixtures/event'
require_relative '../fixtures/publisher'
require_relative '../fixtures/subscribers'

RSpec.describe 'Subscribers' do
  before do
    Observers::Observables.reset

    Object.send(:remove_const, 'Publisher')
    Object.send(:remove_const, 'NilSubscriber')
    Object.send(:remove_const, 'TrueSubscriber')

    load 'spec/fixtures/publisher.rb'
    load 'spec/fixtures/subscribers.rb'
  end

  describe 'Observables#observables' do
    it 'creates an observer' do
      expect(Observers::Observables.observables[Publisher].observers.count).to eq(2)
    end
  end

  describe 'Observers#trigger' do
    context 'when the actionable is a symbol' do
      let(:actionable) { :action }

      before do
        allow(TrueSubscriber).to receive(:action)
      end

      it "triggers an observer's action" do
        Publisher.trigger actionable
        expect(TrueSubscriber).to have_received(:action)
      end

      it "triggers an observer's action via method" do
        Publisher.trigger_via_method(actionable)
        expect(TrueSubscriber).to have_received(:action)
      end
    end

    context 'when the actionable is an event' do
      let(:actionable) { Event.new(action: :action) }

      before do
        allow(TrueSubscriber).to receive(:action).with(event: actionable)
      end

      it "triggers an observer's action" do
        Publisher.trigger actionable
        expect(TrueSubscriber).to have_received(:action)
      end

      it "triggers an observer's action via method" do
        Publisher.trigger_via_method(actionable)
        expect(TrueSubscriber).to have_received(:action)
      end
    end
  end

  describe 'Observers#take' do
    context 'when the actionable is a symbol' do
      let(:actionable) { :action }

      before do
        allow(TrueSubscriber).to receive(:action).and_return(true)
      end

      it "takes an observer's return value" do
        expect(Publisher.take(actionable)).to eq(true)
      end

      it "takes an observer's return value via method" do
        expect(Publisher.take_via_method(actionable)).to eq(true)
      end
    end

    context 'when the actionable is an event' do
      let(:actionable) { Event.new(action: :action) }

      before do
        allow(TrueSubscriber).to receive(:action).with(event: actionable).and_return(true)
      end

      it "takes an observer's return value" do
        expect(Publisher.take(actionable)).to eq(true)
      end

      it "takes an observer's return value via method" do
        expect(Publisher.take_via_method(actionable)).to eq(true)
      end
    end
  end
end
