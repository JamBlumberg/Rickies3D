import Foundation

public class AppState: ObservableObject {
    static var shared = AppState()
    
    @Published public var winners: Winners?
    @Published public var charities: [Charity]?
    @Published public var episodes: [Episode]?
    @Published public var billChanges: [BillChange]?
    @Published public var ineligible: Ineligible?
    @Published public var games: [Game]?
    @Published public var picks: [Picks]?
    @Published public var coinFlips: CoinFlips?
}

