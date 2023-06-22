import Foundation

struct CoinFlipsFetcher {
    enum CoinFlipsFetcherError: Error {
        case invalid
        case missingData
    }
    
    @MainActor
    static func fetchCoinFlips() async throws {
        guard let url = URL(string: "https://rickies.net/api/v1/coinflips.json") else {
            throw CoinFlipsFetcherError.invalid
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let coinFlipsResult = try decoder.decode(CoinFlips.self, from: data)
        AppState.shared.coinFlips = coinFlipsResult
    }
}
