import SwiftUI

public extension EnvironmentValues {
    /// Opens supported web URLs in the nearest installed Safari sheet presenter.
    ///
    /// The default action returns ``OpenSafariSheetResult/discarded``. Install
    /// a presenter with ``View/safariSheetPresenter()`` before
    /// reading this environment value from descendant views.
    @Entry var openSafariSheet = OpenSafariSheetAction { _ in .discarded }
}
