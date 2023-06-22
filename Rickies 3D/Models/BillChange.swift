public struct BillChange: Codable, Equatable, Hashable {
    public let episode: Int
    public let changes: String
    
    public init(episode: Int, changes: String) {
        self.episode = episode
        self.changes = changes
    }
}

