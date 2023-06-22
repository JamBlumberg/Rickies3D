import SwiftUI
import SafariServices

struct EpisodesView: View {
    @ObservedObject var state: AppState
    @State var showSafari: Bool = false
    @State var searchText: String = ""
    var body: some View {
        VStack {
            Text("Episodes")
                .font(.largeTitle)
                List {
                    ForEach(searchResults, id: \.hashValue) { result in
                        Section {
                            Button(action: {
                                showSafari.toggle()
                            }, label: { 
                                Text("Episode Link")
                            }).sheet(isPresented: $showSafari, content: {
                                if let url = URL(string: result.permalink) {
                                    SafariView(url: url)
                                }
                            })
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    Text("Relevant Games: ")
                                    ForEach(result.relevantGames.indices) { gameIndex in
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
                    } || episode.permalink.contains(searchText)
                }
            } else {
                return []
            }
        }
    }
    
}

struct SafariView: UIViewControllerRepresentable {
    
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
    }
}

//struct EpisodesView_Previews: PreviewProvider {
//    static var previews: some View {
//        EpisodesView(state: AppState.shared)
//    }
//}
