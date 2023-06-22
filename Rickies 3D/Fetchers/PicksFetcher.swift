import Foundation

struct PicksFetcher {
    enum PicksFetcherError: Error {
        case invalid
        case missingData
    }
    
    @MainActor
    static func fetchPicks() async throws {
        guard let url = URL(string: "https://rickies.net/api/v1/pick/all.json") else {
            throw PicksFetcherError.invalid
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        do {
            let picksResult = try decoder.decode([Picks].self, from: data)
            AppState.shared.picks = picksResult
        } catch {
            print(error)
        }
    }
}
