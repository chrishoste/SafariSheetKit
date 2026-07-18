# Contributing

Thanks for considering a contribution to SafariSheetKit.

## Project Scope

SafariSheetKit is intentionally small. It provides a SwiftUI environment action for presenting `http` and `https` URLs in an in-app Safari sheet using `SFSafariViewController`.

Changes should preserve these constraints:

- Supported web URLs return `.handled` and present a Safari sheet.
- Unsupported URLs return `.discarded`.
- The package does not automatically fall back to `openURL`.
- The public API stays SwiftUI-first and environment-driven.
- No third-party dependencies.

## Development

Requirements:

- Xcode with Swift 6.2 or later
- iOS 26 SDK or later

Before opening a pull request:

1. Build the package or a host app that imports it.
2. Keep public API changes documented in source comments and DocC.
3. Update `README.md` when behavior changes.
4. Update `CHANGELOG.md` for user-visible changes.

## Style

- Prefer modern SwiftUI APIs.
- Keep implementation details package-internal unless they are intentionally public API.
- Preserve Swift concurrency correctness.
- Avoid force unwraps in library code and documentation examples.
