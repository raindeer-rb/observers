# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
Minor features that don't break backwards compatibility are released as patches.

## 0.3.1 [UNRELEASED]

### Removed

- Remove the need to use `observable` in all situations

## 0.3.0

### Added

- Support observing a complex type like `LowType::Status[200]`

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
