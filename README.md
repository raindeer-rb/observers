<a href="https://rubygems.org/gems/observers" title="Install gem"><img src="https://badge.fury.io/rb/observers.svg" alt="Gem version" height="18"></a>

# Observers

Observer pattern with a much nicer "interface".

## Publisher

Make a class/object `observable` with:
```ruby
class MyPublisher
  extend Observers
  observable
end
```

## Subscriber

`observe` updates from that class/object with:
```ruby
class MySubscriber
  extend Observers
  observe MyPublisher

  def self.action
    # Method that will be called.
  end
end
```

## Triggers

### Methods

```ruby
MyPublisher.trigger :action # => Calls the "action" method on MySubscriber
MyPublisher.take :action # => Calls the "action" method on all observers and returns the first non-nil return value.
```

### Events

Observers integrates with [LowEvent](https://github.com/low-rb/low_event), allowing you to pass an event to your observer.  

Any object that inherits from `LowEvent` is considered an event:

```ruby
# Call the "handle_event(event)" method on all observers to MySubscriber:
MyPublisher.trigger MyEvent.new(event_data)

# Call the "handle_event(event)" method on all observers to MySubscriber and return the first observer's return value that is non-nil:
MyPublisher.take MyEvent.new(event_data)
```

## Architecure

`Observer`s are decoupled from the classes/objects they `observe`. Instead of directly observing a particular `Observable`, we observe the "key" that represents that `Observable`. This allows us to observe entities with arbitrary keys. For more information see [Raindeer](https://github.com/raindeer-rb/raindeer).

## Installation

Add `gem 'observers'` to your Gemfile then:
```
bundle install
```
