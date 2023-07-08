import SwiftUI

struct GamesView: View {
    @ObservedObject var state: AppState
    @State var searchText: String = ""
    @State var reverse: Bool = false
    @State var relevantEpisode: RelevantEpisodes?
    @State var showProgressIndicator: Bool = true
    var body: some View {
        VStack {
            Text("Past Games")
                .font(.largeTitle)
            if showProgressIndicator {
                ProgressView()
            } else {
                List {
                    ForEach(searchResults, id: \.datePicked) { result in
                        Section {
                            Text("Game Type: \(result.gameType)")
                            Text("Date Picked: \(result.datePicked)")
                            Text("Date Graded: \(result.dateGraded)")
                            if let mainGame = result.mainGame {
                                NavigationLink {
                                    PicksView(picks: mainGame.picks)
                                } label: {
                                    Text("Main Game Picks")
                                }
                                Text("Main Game Winner: \(mainGame.winner)")
                                if let coinFlips = mainGame.coinFlips {
                                    if !coinFlips.isEmpty {
                                        NavigationLink {
                                            CoinFlipsView(coinFlips: coinFlips)
                                        } label: {
                                            Text("Main Game Coin Flips")
                                        }
                                    }
                                }
                            }
                            if let theFlexies = result.theFlexies {
                                NavigationLink {
                                    PicksView(picks: theFlexies.picks)
                                } label: {
                                    Text("The Flexies Picks")
                                }
                                if let winner = theFlexies.winner {
                                    Text("The Flexies Winner: \(winner)")
                                }
                                if let coinFlips = theFlexies.coinFlips {
                                    if !coinFlips.isEmpty {
                                        NavigationLink {
                                            CoinFlipsView(coinFlips: coinFlips)
                                        } label: {
                                            Text("The Flexies Coin Flips")
                                        }
                                    }
                                }
                            }
                            if let nongraded = result.nongraded {
                                NavigationLink {
                                    PicksView(picks: nongraded.picks)
                                } label: {
                                    Text("Nongraded picks")
                                }
                            }
                            if let relevantEpisodes = result.relevantEpisodes {
                                ScrollView(.horizontal) {
                                    HStack {
                                        Text("Relevant Episodes: ")
                                        ForEach(relevantEpisodes, id: \.title) { episode in
                                            Button {
                                                Task {
                                                    relevantEpisode = episode
                                                }
                                            } label: {
                                                Text("\(episode.title)  |")
                                            }
                                        }
                                    }
                                }
                            }
                        } header: {
                            Text(result.name)
                        }
                    }
                }
            }
        }
        .foregroundStyle(.black)
        .searchable(text: $searchText, prompt: "Search by episode, game name or type")
        .toolbar {
            ToolbarItem {
                Button {
                    reverse.toggle()
                } label: {
                    reverse ? Image(systemName: "arrow.up") : Image(systemName: "arrow.down")
                }

            }
        }
        .task {
            do {
                try await GamesFetcher.fetchGames()
                showProgressIndicator.toggle()
            } catch {
                print("error fetching games")
            }
        }
        .sheet(item: $relevantEpisode) { episode in
            if let url = URL(string: episode.url) {
                SafariView(url: url)
            }
        }
    }
    
    var searchResults: [Game] {
        if searchText.isEmpty {
            if !reverse {
                return state.games ?? []
            } else {
                return state.games?.reversed() ?? []
            }
        } else {
            if let games = state.games {
                if !reverse {
                    return games.filter {
                        if let relevantEpisodes = $0.relevantEpisodes {
                            return $0.name.contains(searchText) ||
                            $0.gameType.contains(searchText) ||
                            relevantEpisodes.contains {
                                $0.title.range(of: searchText, options: .caseInsensitive) != nil ||
                                $0.url.range(of: searchText, options: .caseInsensitive) != nil
                            }
                        } else {
                            return $0.name.contains(searchText) || $0.gameType.contains(searchText)
                        }
                    }
                } else {
                    return games.reversed().filter {
                        if let relevantEpisodes = $0.relevantEpisodes {
                            return $0.name.contains(searchText) ||
                            $0.gameType.contains(searchText) ||
                            relevantEpisodes.contains {
                                $0.title.range(of: searchText, options: .caseInsensitive) != nil ||
                                $0.url.range(of: searchText, options: .caseInsensitive) != nil
                            }
                        } else {
                            return $0.name.contains(searchText) || $0.gameType.contains(searchText)
                        }
                    }
                }
            } else { return [] }
        }
    }
}

#Preview {
    GamesView(state: AppState.shared)
}
