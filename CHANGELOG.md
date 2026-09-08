# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
Minor features that don't break backwards compatibility are released as patches.

## 1.0.0 [UNRELEASED]

### Changed

- Change `observe :event, :action` behaviour to be the action to accept, not to override

## 0.9.0 [UNRELEASED]

### Added

- Support multiple ordered actions

### Changed

- Rename route to route_request

## 0.8.0

### Added

- Only send event arg when action accepts event

### Changed

- Rename `key_callback` to `empty_observers_callback`

## 0.7.0

### Added

- Add `Observers[key]` API that returns observers
- Add callback when key without observers

## 0.6.0

### Changed

- Rename Observable to Key
- Use keyword argument for trigger/take key param
- Support block usage when triggering observers

## 0.5.0

### Added

- Reintroduce take method

## 0.4.0

### Added

- Add observers on the observable side via `observers`

### Removed

- Remove the `observable` method
- Remove `order` param

## 0.3.0

### Added

- Support observing a complex type like `Low::Types::Status[200]`

### Changed

- Formalise `trigger` API to use `action` and `event` keyword arguments

### Removed

- Remove the need to use `observable` in basic situations
- Remove take method

## 0.2.0

### Added

- Allow observer to override action handler

## 0.1.0

### Added

- Introduce take method
