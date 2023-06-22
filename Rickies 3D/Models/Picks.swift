public struct Picks: Codable, Equatable {
    public let text: String
    public let notes: String
    public let game: String
    public let type: String
    public let topics: [String]
    public let host: String
    public let pickConditions: Int?
    public let score: Double?
    public let aheadBy: Int? 
    public let overcastPicked: String?
    public let overcastGraded: String?
    
    public init(text: String, notes: String, game: String, type: String, topics: [String], host: String, pickConditions: Int, score: Double?, aheadBy: Int?, overcastPicked: String?, overcastGraded: String?) {
        self.text = text
        self.notes = notes
        self.game = game
        self.type = type
        self.topics = topics
        self.host = host
        self.pickConditions = pickConditions
        self.score = score
        self.aheadBy = aheadBy
        self.overcastPicked = overcastPicked
        self.overcastGraded = overcastGraded
    }
    
    private enum Codingkeys: String, CodingKey {
        case text
        case notes
        case game
        case type
        case topics
        case host
        case pickConditions = "pick-conditions"
        case score
        case aheadBy = "ahead-by"
        case overcastPicked = "overcast-picked"
        case overcastGraded = "overcast-graded"
    }
}
