<a href="https://rubygems.org/gems/observers" title="Install gem"><img src="https://badge.fury.io/rb/observers.svg" alt="Gem version" height="18"></a>

# Observers

Observe objects of any kind and trigger actions/events on them.

Observers are decoupled from the objects they observe. Instead of directly observing a particular object, we observe the "key" that represents that object. Anything can be observed out of the box; a class, an object, a struct, symbol or string. You just need to `observe` it:

```ruby
class MySubscriber
  include Observers
  observe MyPublisher

  def self.handle
    # Method that will be called upon trigger.
  end
end
```

You can also add observers from the object being observed:
```ruby
class MyPublisher
  include Observers
  observers << MySubscriber
end
```

ℹ️ **Note:** Observers are called in the order that they are defined.

## Triggers

`include Observers` in the class that you'd like to trigger actions/events from:

```ruby
class MyPublisher
  include Observers
  # "trigger" method now available on class and instance.
end
```

### Actions

Calls the `my_action` method on MySubscriber and returns the last observer's return value that was non-nil:
```ruby
MyPublisher.trigger action: :my_action
```

Trigger the action on any observers to `any_object_or_class`:
```ruby
MyPublisher.trigger any_object_or_class, action: :my_action
```

### Events

Observers integrates with [LowEvent](https://github.com/low-rb/low_event), allowing you to pass an event to your observer.

Calls the `handle(event:)` method on all observers to `MySubscriber` and return the last observer's return value that was non-nil:
```ruby
MyPublisher.trigger event: LowEvent.new(event_data)
```

Trigger the event on any observers to `any_object_or_class`:
```ruby
MyPublisher.trigger any_object_or_class, event: LowEvent.new(event_data)
```

ℹ️ **Note:** Events should inherit from `LowEvent` or replicate its methods and attributes.

### Default Action

The default action that will be called on an observer is `handle` or `handle(event:)` if the action, event or `action` don't specify this.

### Overriding Actions

An action can be overridden at each layer:
1. On the `trigger` method by including an `action:` keyword argument
2. On the event by populating its `action` attribute
3. On the observer by configuring an `action:` on `observe`:
```ruby
class MySubscriber
  include Observers
  observe MyPublisher, action: :clear_cache

  def self.clear_cache
    # The `clear_cache` method will be called regardless of the trigger's action/event's action.
  end
end
```

### Action Precedence

1. `observe action:` and `observers << my_object, action:` - Overrides `trigger` and event actions
2. `trigger action:` - Overrides event actions
3. Event's `@action` - Overrides Observers' default action

## API

### Observers

The `observers` method is more flexible than it seems.

Reference a different object to observe with:
```ruby
observers(my_object) << my_observer
```

Override the action called on the observer with:
```ruby
observers.push(my_observer, action: :overridden_action)
```

ℹ️ **Note:** `push` needs to be used instead of `<<` in this situation so that Ruby doesn't get confused about the syntax.

### Actions

- `trigger` - Calls all observers. Returns the last non-nil value.
- `take` - Calls all observers up until the first non-nil value. Returns the first non-nil value.

## Installation

Add `gem 'observers'` to your Gemfile then:
```
bundle install
```
