import Foundation

struct CharitiesFetcher {
    enum CharitiesFetcherError: Error {
        case invalid
        case missingData
    }
    
    @MainActor
    static func fetchCharities() async throws {
        guard let url = URL(string: "https://rickies.net/api/v1/charity.json") else {
            throw CharitiesFetcherError.invalid
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        do {
            let charitiesResult = try decoder.decode([Charity].self, from: data)
            AppState.shared.charities = charitiesResult
        } catch {
            print(error)
        }
    }
}
