import SwiftUI

struct CoinFlipsView: View {
    @State var coinFlips: [CoinFlips]
    @State var showSafari: Bool = false
    var body: some View {
        VStack {
            List {
                ForEach(coinFlips, id:\.game) { flip in
                    Section {
                        Text("Flip method: \(flip.flipMethod)")
                        Text("Result: \(flip.result)")
                        Text("Winner: \(flip.winner)")
                        Text("Loser: \(flip.loser)")
                        Button {
                            showSafari.toggle()
                        } label: {
                            Text("Overcast link")
                        }.sheet(isPresented: $showSafari, content: {
                            if let url = URL(string: flip.overcastLink) {
                                SafariView(url: url)
                            }
                        })
                    } header: {
                        Text(flip.game)
                    }
                }
            }
        }
        .navigationTitle(Text("Coin Flips"))
    }
}


