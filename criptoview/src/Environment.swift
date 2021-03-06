import Foundation

struct Environment {
    static var nomicsTestsApiKey: String {
        variable("TESTS_NOMICS_API_KEY") ?? CiKeys.nomicsTestsApiKey
    }

    private init() {}

    private struct CiKeys {
        private init() {}

        static let nomicsTestsApiKey = "$(TESTS_NOMICS_API_KEY)"
    }

    private static func variable(_ name: String) -> String? {
        ProcessInfo.processInfo.environment[name]
    }
}
