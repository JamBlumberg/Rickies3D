import Foundation

struct EpisodesFetcher {
    enum EpisodesFetcherError: Error {
        case invalid
        case missingData
    }
    
    @MainActor
    static func fetchEpisodes() async throws {
        guard let url = URL(string: "https://rickies.net/api/v1/episodes.json") else {
            throw EpisodesFetcherError.invalid
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        do {
            let episodesResult = try decoder.decode([Episode].self, from: data)
            AppState.shared.episodes = episodesResult
        } catch {
            throw EpisodesFetcherError.missingData
        }
    }
}
