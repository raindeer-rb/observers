<a href="https://rubygems.org/gems/observers" title="Install gem"><img src="https://badge.fury.io/rb/observers.svg" alt="Gem version" height="18"></a>

# Observers

Observer pattern with a much nicer "interface".

## Publisher

Make a class/object `observable` with:
```ruby
class Publisher
  extend Observers
  observable
end
```

## Subscriber

`observe` updates from that class/object with:
```ruby
class Subscriber
  extend Observers
  observe Publisher

  def action
    # Method that will be called.
  end
end
```

## Triggers

### Method Trigger

```ruby
Publisher.trigger :action # => Calls the "action" method on Subscriber
```

### Event Trigger [UNRELEASED]

```ruby
Publisher.trigger Event.new(action: :action) # => Calls the "action" method on Subscriber
```

## Installation

Add `gem 'observers'` to your Gemfile then:
```
bundle install
```
