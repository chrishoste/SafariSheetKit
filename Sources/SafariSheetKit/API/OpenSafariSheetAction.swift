import Foundation

/// The outcome of a request to present a URL in a Safari sheet.
public enum OpenSafariSheetResult: Sendable {
    /// The URL was accepted and presentation was requested.
    case handled

    /// The URL was not accepted by the installed presenter.
    ///
    /// This is returned for unsupported URL schemes, or when no
    /// ``View/safariSheetPresenter()`` has been installed above the caller.
    case discarded
}

/// An environment action that presents supported web URLs in a Safari sheet.
///
/// Read this action from SwiftUI's environment using
/// `@Environment(\.openSafariSheet)`, then call it with the URL you want to
/// present.
///
/// ```swift
/// @Environment(\.openSafariSheet) private var openSafariSheet
///
/// Button("Open Website", systemImage: "safari") {
///     openSafariSheet(url)
/// }
/// ```
///
/// The action returns ``OpenSafariSheetResult`` so callers can decide how to
/// handle unsupported URLs.
public struct OpenSafariSheetAction: Sendable {
    let action: @MainActor @Sendable (URL) -> OpenSafariSheetResult

    /// Creates an action with the supplied implementation.
    ///
    /// - Parameter action: A main-actor-isolated closure that handles a URL and
    ///   returns the presentation result.
    public init(action: @escaping @MainActor @Sendable (URL) -> OpenSafariSheetResult) {
        self.action = action
    }

    /// Presents the URL in a Safari sheet when possible.
    ///
    /// Supported URLs use the `http` or `https` scheme. Unsupported URLs return
    /// ``OpenSafariSheetResult/discarded``.
    ///
    /// - Parameter url: The URL to present.
    /// - Returns: A result describing whether the URL was handled.
    @MainActor
    @discardableResult
    public func callAsFunction(_ url: URL) -> OpenSafariSheetResult {
        action(url)
    }
}
