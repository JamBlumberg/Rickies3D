public struct CoinFlips: Codable, Equatable {
    public let game: String
    public let called: String
    public let caller: String
    public let flipMethod: String
    public let gamePhase: String
    public let loser: String
    public let overcastLink: String
    public let prize: Int
    public let result: String
    public let winner: String
    
    public init(game: String, called: String, caller: String, flipMethod: String, gamePhase: String, loser: String, overcastLink: String, prize: Int, result: String, winner: String) {
        self.game = game
        self.called = called
        self.caller = caller
        self.flipMethod = flipMethod
        self.gamePhase = gamePhase
        self.loser = loser
        self.overcastLink = overcastLink
        self.prize = prize
        self.result = result
        self.winner = winner
    }
    
    private enum CodingKeys: String, CodingKey {
        case game
        case called
        case caller
        case flipMethod = "flip-method"
        case gamePhase = "game-phase"
        case loser
        case overcastLink = "overcast-link"
        case prize
        case result
        case winner
    }
}
