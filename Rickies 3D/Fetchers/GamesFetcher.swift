import Foundation

struct GamesFetcher {
    enum GamesFetcherError: Error {
        case invalid
        case missingData
    }
    
    @MainActor
    static func fetchGames() async throws {
        guard let url = URL(string: "https://rickies.net/api/v1/game/all.json") else {
            throw GamesFetcherError.invalid
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        do {
            let gamesResult = try decoder.decode([Game].self, from: data)
            AppState.shared.games = gamesResult
        } catch {
            print(error)
        }
    }
}
