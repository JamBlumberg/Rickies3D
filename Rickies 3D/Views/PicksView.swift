import SwiftUI

struct PicksView: View {
    @State var picks: [Picks]
    
    var body: some View {
        VStack {
            let keys = picksByHost().map{ $0.key }
            let values = picksByHost().map{ $0.value }
            List {
                ForEach(keys.indices) { index in
                    Section {
                        ForEach(values[index], id: \.text) { pick in
                            Text(pick.text)
                            if let score = pick.score {
                                Text("Score: \(String(format: "%.1f", score))")
                            }
                        }
                    } header: {
                        Text(keys[index])
                    }
                }
            }
        }
        .navigationTitle(Text("Picks"))
    }
    
    func picksByHost() -> [String:[Picks]] {
        guard !picks.isEmpty else { return [:] }
        let dictionaryByHost = Dictionary(grouping: picks, by: { $0.host} )
        return dictionaryByHost
    }
}
