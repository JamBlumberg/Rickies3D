import Foundation

struct IneligibleFetcher {
    enum IneligibleFetcherError: Error {
        case invalid
        case missingData
    }
    
    @MainActor
    static func fetchBillChanges() async throws {
        guard let url = URL(string: "https://rickies.net/api/v1/ineligible.json") else {
            throw IneligibleFetcherError.invalid
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let ineligibleResult = try decoder.decode(Ineligible.self, from: data)
        AppState.shared.ineligible = ineligibleResult
    }
}
