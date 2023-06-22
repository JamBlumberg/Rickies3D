public struct Ineligible: Codable, Equatable {
    public let stephen: [Picks]
    public let myke: [Picks]
    public let fedrico: [Picks]
    
    public init(stephen: [Picks], myke: [Picks], federico: [Picks]) {
        self.stephen = stephen
        self.myke = myke
        self.fedrico = federico
    }
}
