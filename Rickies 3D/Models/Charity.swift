public struct Charity: Codable, Equatable {
    public let game: String
    public let donator: String
    public let donation: Int
    public let charityName: String
    public let charityURL: String
    
    public init(game: String, donator: String, donation: Int, charityName: String, charityURL: String) {
        self.game = game
        self.donator = donator
        self.donation = donation
        self.charityName = charityName
        self.charityURL = charityURL
    }
    
    private enum CodingKeys: String, CodingKey {
        case game
        case donator
        case donation
        case charityName = "charity-name"
        case charityURL = "charity-url"
    }
}
