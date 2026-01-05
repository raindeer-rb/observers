<a href="https://rubygems.org/gems/observers" title="Install gem"><img src="https://badge.fury.io/rb/observers.svg" alt="Gem version" height="18"></a>

# Observers

Observer pattern with a much nicer "interface".

## Publisher

Make a class/object `observable` with:
```ruby
class MyPublisher
  include Observers
  observable
end
```

## Subscriber

`observe` updates from that class/object with:
```ruby
class MySubscriber
  include Observers
  observe MyPublisher

  def self.action
    # Method that will be called upon trigger.
  end
end
```

## Triggers

### Actions

```ruby
MyPublisher.trigger :action # => Calls the "action" method on MySubscriber
MyPublisher.take :action # => Calls the "action" method on all observers and returns the first non-nil observer return value.
```

### Events

Observers integrates with [LowEvent](https://github.com/low-rb/low_event), allowing you to pass an event to your observer:

```ruby
# Call the "handle(event:)" method on all observers to MySubscriber:
MyPublisher.trigger LowEvent.new(event_data)

# Call the "handle(event:)" method on all observers to MySubscriber and return the first observer's return value that is non-nil:
MyPublisher.take LowEvent.new(event_data)
```

ℹ️ **Note:** Any object that inherits from `LowEvent` is considered an event.

## Observer Action

The default action that will be called on an observer is `handle` or `handle(event:)`, which can be overidden on the `Observable` side, as seen via triggers as seen above.  
You can also override the action handler on the `Observer` side, to always be a certain action regardless of the `Observable` trigger's action/event's action.

```ruby
class MySubscriber
  extend Observers
  observe MyPublisher, :clear_cache

  def self.clear_cache
    # All triggers will call this action regardless of their action.
  end
end
```

## Architecure

`Observer`s are decoupled from the classes/objects they `observe`. Instead of directly observing a particular `Observable`, we observe the "key" that represents that `Observable`. This allows us to observe entities with arbitrary keys; classes, objects, strings or symbols are all suitable.

**Observers uses the singleton pattern and for good reasons:**
- Observers operates primarily at the class level. Injecting itself as a dependency to other class methods would mean just referencing global constants anyway
- Class level `Observable`s and their associated `Observer`s can be added independently of each other in either order
- Observers is the glue connecting various classes together, but in a dynamic and decoupled way where each observable/observer relationship is not hardcoded
- The very nature of connecting classes is a global task. This global state could be stored in a single central object which would become a... singleton

ℹ️ **Note:** If you know of a better way to achieve the goals of Observers then I would really like to hear about it, just open an issue or pull request.

## Installation

Add `gem 'observers'` to your Gemfile then:
```
bundle install
```
