import Foundation

public struct Episode: Codable, Equatable, Hashable {
    public let episode: Int
    public let permalink: URL
    public let relevantGames: [String]
    
    public init(episode: Int, permalink: String, relvantGames: [String]) {
        self.episode = episode
        if let url = URL(string: permalink) {
            self.permalink = url
        } else {
            self.permalink = URL(string: "rickies.net") ?? .currentDirectory()
        }
        self.relevantGames = relvantGames
    }
    
    private enum CodingKeys: String, CodingKey {
        case episode
        case permalink
        case relevantGames = "relevant-games"
    }
}
