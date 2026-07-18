import Foundation
import Testing
@testable import SafariSheetKit

@Suite("Safari sheet URL support")
struct SafariSheetURLTests {
    @Test(
        "Accepts HTTP and HTTPS URLs",
        arguments: [
            "http://example.com",
            "https://example.com",
            "HTTPS://example.com"
        ]
    )
    func acceptsWebURLs(urlString: String) throws {
        let url = try #require(URL(string: urlString))

        #expect(url.isWebURL)
    }

    @Test(
        "Rejects unsupported or missing URL schemes",
        arguments: [
            "ftp://example.com/file.zip",
            "mailto:hello@example.com",
            "tel:+49123456789",
            "example.com"
        ]
    )
    func rejectsUnsupportedURLs(urlString: String) throws {
        let url = try #require(URL(string: urlString))

        #expect(!url.isWebURL)
    }
}
