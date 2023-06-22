public struct Episode: Codable, Equatable, Hashable {
    public let episode: Int
    public let permalink: String
    public let relevantGames: [String]
    
    public init(episode: Int, permalink: String, relvantGames: [String]) {
        self.episode = episode
        self.permalink = permalink
        self.relevantGames = relvantGames
    }
    
    private enum CodingKeys: String, CodingKey {
        case episode
        case permalink
        case relevantGames = "relevant-games"
    }
}
