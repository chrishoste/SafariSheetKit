# SafariSheetKit

SafariSheetKit is a small SwiftUI package for presenting web URLs in an in-app Safari sheet.

It exposes an environment action that feels similar to SwiftUI's `openURL`, but is intentionally scoped to `http` and `https` URLs. Supported URLs are presented with `SFSafariViewController`; unsupported URLs are ignored and reported as `.discarded`.

## Requirements

- iOS 26.0 or later
- Swift 6.2 or later
- SwiftUI

## Installation

Add this repository as a Swift Package dependency in Xcode:

1. Open your Xcode project.
2. Choose **File > Add Package Dependencies**.
3. Enter the package URL.
4. Add the `SafariSheetKit` product to your app target.

For a local package, add the `SafariSheetKit` folder as a local package dependency.

## Quick Start

Import the package:

```swift
import SafariSheetKit
```

Install the presenter once on an ancestor view, usually at your scene root:

```swift
@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .safariSheetPresenter()
        }
    }
}
```

Open a URL from any descendant view:

```swift
struct ContentView: View {
    @Environment(\.openSafariSheet) private var openSafariSheet

    let url = URL(string: "https://www.apple.com")

    var body: some View {
        if let url {
            Button("Open Website", systemImage: "safari") {
                openSafariSheet(url)
            }
        }
    }
}
```

## Handling Unsupported URLs

`SFSafariViewController` supports web URLs only. SafariSheetKit accepts any `URL` at the call site, then validates the scheme inside the presenter.

```swift
let result = openSafariSheet(url)

switch result {
case .handled:
    // The URL was presented in the Safari sheet.
case .discarded:
    // The URL was not a supported web URL.
}
```

Supported schemes:

- `http`
- `https`

Unsupported examples:

- `mailto:`
- `tel:`
- custom app deep links
- file URLs

SafariSheetKit does not fall back to `openURL` automatically. This keeps the action predictable: it either presents an in-app Safari sheet or returns `.discarded`. If your app wants fallback behavior, handle `.discarded` at the call site and call SwiftUI's `openURL` yourself.

## API Reference

### `safariSheetPresenter()`

Installs the sheet presenter and injects `openSafariSheet` into the SwiftUI environment.

Apply this modifier once above every view that needs to open Safari sheets:

```swift
RootView()
    .safariSheetPresenter()
```

If a view reads `openSafariSheet` without an installed presenter, the default action returns `.discarded`.

### `openSafariSheet`

An environment action used to request presentation of a URL:

```swift
@Environment(\.openSafariSheet) private var openSafariSheet
```

Call it from a button, list row, menu command, toolbar item, or any other action:

```swift
openSafariSheet(url)
```

The return value can be ignored for simple use cases, or inspected when the caller needs to react to unsupported URLs.

### `OpenSafariSheetResult`

The result returned by `openSafariSheet`.

- `.handled`: the URL was accepted and the Safari sheet was presented.
- `.discarded`: the URL was unsupported or no presenter was installed.

## Behavior

SafariSheetKit uses `SFSafariViewController`, so the displayed page uses Safari's system-provided browsing experience inside your app. This includes Safari privacy and security behavior, reader support where available, and system-managed web presentation.

The package does not expose `SFSafariViewController` directly. The public API is SwiftUI-native and environment-driven, which keeps call sites decoupled from the underlying presentation mechanism.

## Design Goals

- Provide a drop-in SwiftUI action for opening web URLs in a sheet.
- Keep presentation state at the view root instead of at every call site.
- Avoid crashing on unsupported URL schemes.
- Keep fallback behavior explicit and app-controlled.
- Keep the package small enough to audit quickly.

## Example With Fallback

If your app wants unsupported URLs to use SwiftUI's normal URL handling, combine `openSafariSheet` with `openURL`:

```swift
struct LinkButton: View {
    @Environment(\.openSafariSheet) private var openSafariSheet
    @Environment(\.openURL) private var openURL

    let url: URL

    var body: some View {
        Button("Open") {
            if openSafariSheet(url) == .discarded {
                openURL(url)
            }
        }
    }
}
```

## Contributing

Keep the package focused on SwiftUI sheet presentation for web URLs. New features should preserve the core behavior: `http` and `https` URLs are handled in-app, unsupported URLs are reported as `.discarded`, and app-specific fallback behavior stays at the call site.

Before opening a pull request:

- Build the package or host app.
- Keep public API additions documented.
- Avoid adding third-party dependencies.
- Preserve Swift 6 concurrency correctness.
