# frozen_string_literal: true

require_relative '../../lib/observers'

RSpec.describe 'Observe syntax' do
  subject(:subscriber) { Class.new { include Observers } }

  before do
    Observers::Keys.reset
  end

  def observed_action(key)
    Observers::Keys[key].observers.last.action
  end

  it 'observes a key' do
    subscriber.observe('/feedback')

    expect(Observers::Keys['/feedback'].observers.count).to eq(1)
    expect(observed_action('/feedback')).to be_nil
  end

  it 'observes a key with an action keyword' do
    subscriber.observe '/feedback', action: :post

    expect(observed_action('/feedback')).to eq(:post)
  end

  it 'observes a string key with the hash syntax' do
    subscriber.observe '/feedback' => :post

    expect(observed_action('/feedback')).to eq(:post)
  end

  it 'observes multiple keys with the hash syntax' do
    subscriber.observe '/feedback' => :post, '/contact' => :put

    expect([observed_action('/feedback'), observed_action('/contact')]).to eq(%i[post put])
  end

  it 'observes a symbol key with the hash syntax' do
    subscriber.observe :feedback => :post # rubocop:disable Style/HashSyntax

    expect(observed_action(:feedback)).to eq(:post)
  end

  it 'observes a class key with the hash syntax' do
    key = Class.new
    subscriber.observe key => :post

    expect(observed_action(key)).to eq(:post)
  end

  it 'raises without a key' do
    expect { subscriber.observe }.to raise_error(ArgumentError, 'Missing key to observe')
  end
end
