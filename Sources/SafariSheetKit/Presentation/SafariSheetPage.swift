import Foundation

/// A lightweight sheet destination for the selected web URL.
struct SafariSheetPage: Identifiable {
    let id = UUID()
    let url: URL
}
