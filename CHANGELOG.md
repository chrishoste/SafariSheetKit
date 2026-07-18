# Changelog

All notable changes to SafariSheetKit will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project follows semantic versioning once tagged releases begin.

## Unreleased

### Added

- Initial SwiftUI environment action for presenting `http` and `https` URLs in an in-app Safari sheet.
- `OpenSafariSheetResult` with `.handled` and `.discarded` outcomes.
- `safariSheetPresenter()` root modifier for installing the presenter.
- DocC documentation and README usage guide.
- Swift Testing coverage for action results and URL validation.

### Changed

- `OpenSafariSheetResult` now conforms to `Equatable`.
