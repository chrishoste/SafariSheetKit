import SwiftUI

public extension View {
    /// Installs a Safari sheet presenter and injects `openSafariSheet`.
    ///
    /// Apply this modifier once on an ancestor view, commonly at the app's scene
    /// root:
    ///
    /// ```swift
    /// ContentView()
    ///     .safariSheetPresenter()
    /// ```
    ///
    /// Descendant views can then read `@Environment(\.openSafariSheet)` and use
    /// that action to request presentation.
    ///
    /// - Returns: A view that can present supported web URLs in a Safari sheet.
    func safariSheetPresenter() -> some View {
        modifier(SafariSheetPresenterModifier())
    }
}
