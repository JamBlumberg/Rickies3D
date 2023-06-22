import Foundation


public enum GameType: String, Codable {
    case keynote = "Keynote"
    case annual = "Annual"
    case other = "Other"
}

public struct MainScore: Codable, Equatable {
    public let host: String
    public let score: Double
    
    public init(host: String, score: Double) {
        self.host = host
        self.score = score
    }
}

public struct FlexieScore: Codable, Equatable {
    public let host: String
    public let correct: Int
    public let total: Int
    
    public init(host: String, correct: Int, total: Int) {
        self.host = host
        self.correct = correct
        self.total = total
    }
}

public struct MainGame: Codable, Equatable {
    public let picks: [Picks]
    public let coinFlips: [CoinFlips]?
    public let scores: [MainScore]?
    public let winner: String
    
    public init(picks: [Picks], coinFlips: [CoinFlips]?, scores: [MainScore]?, winner: String) {
        self.picks = picks
        self.coinFlips = coinFlips
        self.scores = scores
        self.winner = winner
    }
    
    private enum CodingKeys: String, CodingKey {
        case picks
        case coinFlips = "coin-flips"
        case scores
        case winner
    }
}

public struct TheFlexies: Codable, Equatable {
    public let picks: [Picks]
    public let coinFlips: [CoinFlips]?
    public let scores: [FlexieScore]?
    public let charityName: String?
    public let charityURL: String?
    public let donation: Int?
    public let donator: String?
    public let winner: String?
    
    public init(picks: [Picks], coinFlips: [CoinFlips]?, scores: [FlexieScore]?, charityName: String?, charityURL: String?, donation: Int?, donator: String?, winner: String?) {
        self.picks = picks
        self.coinFlips = coinFlips
        self.scores = scores
        self.charityName = charityName
        self.charityURL = charityURL
        self.donation = donation
        self.donator = donator
        self.winner = winner
    }
    
    private enum CodingKeys: String, CodingKey {
        case picks
        case coinFlips = "coin-flips"
        case scores
        case charityName = "charity-name"
        case charityURL = "charity-url"
        case donation
        case donator
        case winner
    }
}

public struct Nongraded: Codable, Equatable {
    public let picks: [Picks]
    public let winner: String?
    
    public init(picks: [Picks], winner: String?) {
        self.picks = picks
        self.winner = winner
    }
}

public struct RelevantEpisodes: Codable, Equatable, Identifiable {
    public var id: UUID?
    public let title: String
    public let url: String
    public let episodeNumber: Int?
    
    public init(id: UUID? = UUID(), title: String, url: String, episodeNumber: Int?) {
        self.id = id
        self.title = title
        self.url = url
        self.episodeNumber = episodeNumber
    }
}

public struct Game: Codable, Equatable {
    public let name: String
    public let gameType: String
    public let datePicked: String
    public let dateGraded: String
    public let mainGame: MainGame?
    public let theFlexies: TheFlexies?
    public let nongraded: Nongraded?
    public let relevantEpisodes: [RelevantEpisodes]?
    
    public init(name: String, gameType: String, datePicked: String, dateGraded: String, mainGame: MainGame?, theFlexies: TheFlexies?, nongraded: Nongraded?, relevantEpisodes: [RelevantEpisodes]?) {
        self.name = name
        self.gameType = gameType
        self.datePicked = datePicked
        self.dateGraded = dateGraded
        self.mainGame = mainGame
        self.theFlexies = theFlexies
        self.nongraded = nongraded
        self.relevantEpisodes = relevantEpisodes
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case gameType = "game-type"
        case datePicked = "date-picked"
        case dateGraded = "date-graded"
        case mainGame = "main-game"
        case theFlexies = "the-flexies"
        case nongraded
        case relevantEpisodes = "relevant-episodes"
    }
}
