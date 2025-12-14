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

### Method Trigger

```ruby
MyPublisher.trigger :action # => Calls the "action" method on MySubscriber
```

### Event Trigger

Any object that has an `action` method is considered an event:

```ruby
MyPublisher.trigger LowEvent.new(action: :action) # => Calls the "action" method on MySubscriber
```

## Installation

Add `gem 'observers'` to your Gemfile then:
```
bundle install
```

## Integrations

Observers integrates with [LowEvent](https://github.com/low-rb/low_event), allowing you to create an event each time you trigger an action.
