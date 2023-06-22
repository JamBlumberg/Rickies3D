public struct Annual: Codable, Equatable {
    public let gameName: String
    public let date: String
    public let winner: String
    public let social: String
    public let title: String
    
    public init(gameName: String, date: String, winner: String, social: String, title: String) {
        self.gameName = gameName
        self.date = date
        self.winner = winner
        self.social = social
        self.title = title
    }
    
    private enum CodingKeys: String, CodingKey {
        case gameName = "game-name"
        case date
        case winner
        case social
        case title
    }
}

public struct Keynote: Codable, Equatable {
    public let gameName: String
    public let date: String
    public let winner: String
    public let social: String
    public let title: String
    
    public init(gameName: String, date: String, winner: String, social: String, title: String) {
        self.gameName = gameName
        self.date = date
        self.winner = winner
        self.social = social
        self.title = title
    }
    
    private enum CodingKeys: String, CodingKey {
        case gameName = "game-name"
        case date
        case winner
        case social
        case title
    }
}

public struct Flexies: Codable, Equatable {
    public let gameName: String
    public let date: String
    public let winner: String
    public let title: String
    public let social: String
    
    public init(gameName: String, date: String, winner: String, title: String, social: String) {
        self.gameName = gameName
        self.date = date
        self.winner = winner
        self.title = title
        self.social = social
    }
    
    private enum CodingKeys: String, CodingKey {
        case gameName = "game-name"
        case date
        case winner
        case social
        case title
    }
}

public struct Winners: Codable, Equatable {
    public let annual: Annual
    public let keynote: Keynote
    public let flexies: Flexies
    public let theTrickyImage: String
    
    public init(annual: Annual, keynote: Keynote, flexies: Flexies, theTrickyImage: String) {
        self.annual = annual
        self.keynote = keynote
        self.flexies = flexies
        self.theTrickyImage = theTrickyImage
    }
    
    private enum CodingKeys: String, CodingKey {
        case annual
        case keynote
        case flexies
        case theTrickyImage = "the-tricky-image"
    }
}
