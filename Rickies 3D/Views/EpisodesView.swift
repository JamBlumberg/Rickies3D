import SwiftUI
import SafariServices

struct EpisodesView: View {
    @ObservedObject var state: AppState
    @State var searchText: String = ""
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        VStack {
            Text("Episodes")
                .font(.largeTitle)
                .padding(.top)
                List {
                    ForEach(searchResults, id: \.hashValue) { result in
                        Section {
                            Button(action: {
                                openURL(result.permalink)
                            }, label: {
                                Text("Episode Link")
                            })
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    Text("Relevant Games: ")
                                    ForEach(result.relevantGames.indices, id: \.self) { gameIndex in
                                            if gameIndex != result.relevantGames.count - 1 {
                                                Text(result.relevantGames[gameIndex])
                                                Text("| ")
                                            } else {
                                                Text(result.relevantGames[gameIndex])
                                            }
                                    }
                                }
                            }
                        } header : {
                            Text("Episode Number: \(result.episode)")
                        }
                    } 
                }
        }
        .foregroundStyle(.black)
        .searchable(text: $searchText, prompt: Text("Search for an episode by game or number"))
        .task {
            do {
                try await EpisodesFetcher.fetchEpisodes()
            } catch {
                print("error fetching episodes")
            }
        }
    }
    
    var searchResults: [Episode] {
        if searchText.isEmpty {
            return state.episodes ?? []
        } else {
            if let episodes = state.episodes {
                return episodes.filter { episode in 
                    episode.relevantGames.contains { game in
                        game.range(of: searchText, options: .caseInsensitive) != nil
                    } || episode.permalink.absoluteString.contains(searchText)
                }
            } else {
                return []
            }
        }
    }
    
}

