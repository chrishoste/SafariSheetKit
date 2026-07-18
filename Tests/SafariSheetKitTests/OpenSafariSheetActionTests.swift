import Foundation
import SwiftUI
import Testing
@testable import SafariSheetKit

@Suite("OpenSafariSheetAction")
struct OpenSafariSheetActionTests {
    @MainActor
    @Test(
        "Returns the result produced by its handler",
        arguments: [
            OpenSafariSheetResult.handled,
            OpenSafariSheetResult.discarded
        ]
    )
    func returnsHandlerResult(expectedResult: OpenSafariSheetResult) throws {
        let url = try #require(URL(string: "https://example.com"))

        let action = OpenSafariSheetAction { receivedURL in
            #expect(receivedURL == url)
            return expectedResult
        }

        #expect(action(url) == expectedResult)
    }

    @MainActor
    @Test("Default environment action discards URLs")
    func defaultEnvironmentActionDiscardsURLs() throws {
        let environment = EnvironmentValues()
        let url = try #require(URL(string: "https://example.com"))

        #expect(environment.openSafariSheet(url) == .discarded)
    }
}
