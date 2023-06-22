import Foundation

struct WinnersFetcher {
    enum WinnersFetcherError: Error {
        case invalid
        case missingData
    }
    
    @MainActor
    static func fetchWinners() async throws {
        guard let url = URL(string: "https://rickies.net/api/v1/winners.json") else {
            throw WinnersFetcherError.invalid
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        do {
            let winnersResult = try decoder.decode(Winners.self, from: data)
            AppState.shared.winners = winnersResult
        } catch {
            throw WinnersFetcherError.missingData
        }
    }
}

