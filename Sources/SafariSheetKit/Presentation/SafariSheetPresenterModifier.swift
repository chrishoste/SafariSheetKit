import SwiftUI

/// Owns Safari sheet presentation state and installs the environment action.
struct SafariSheetPresenterModifier: ViewModifier {
    @State var presentedPage: SafariSheetPage?

    func body(content: Content) -> some View {
        content
            .environment(\.openSafariSheet, OpenSafariSheetAction { url in
                guard url.isWebURL else {
                    return .discarded
                }

                presentedPage = SafariSheetPage(url: url)
                return .handled
            })
            .sheet(item: $presentedPage) { page in
                SafariSheet(url: page.url)
                    .ignoresSafeArea()
            }
    }
}

extension URL {
    /// Whether the URL can be presented by `SFSafariViewController`.
    var isWebURL: Bool {
        guard let scheme = scheme?.lowercased() else {
            return false
        }

        return scheme == "http" || scheme == "https"
    }
}
