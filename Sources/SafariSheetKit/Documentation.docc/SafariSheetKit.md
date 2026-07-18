# ``SafariSheetKit``

Present web URLs in an in-app Safari sheet from anywhere in a SwiftUI view hierarchy.

## Overview

SafariSheetKit provides a SwiftUI environment action for opening supported web URLs in `SFSafariViewController`.

Install the presenter once near the root of your view hierarchy:

```swift
ContentView()
    .safariSheetPresenter()
```

Then request presentation from any descendant view:

```swift
struct ContentView: View {
    @Environment(\.openSafariSheet) private var openSafariSheet

    let url: URL

    var body: some View {
        Button("Open Website", systemImage: "safari") {
            openSafariSheet(url)
        }
    }
}
```

The action handles only `http` and `https` URLs. Unsupported URLs return ``OpenSafariSheetResult/discarded``.

## Topics

### Installing the Presenter

- ``View/safariSheetPresenter()``

### Opening URLs

- ``EnvironmentValues/openSafariSheet``
- ``OpenSafariSheetAction``
- ``OpenSafariSheetResult``
