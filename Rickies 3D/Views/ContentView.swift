import SwiftUI
import RealityKit

struct ContentView: View {
    @StateObject var state = AppState.shared
    @State var showSafari: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    enum ShownView {
        case none, winners, charities, episodes, pastGames
    }
    
    @State var shownView: ShownView = .none
    
    var body: some View {
        TabView {
            buildHomeView()
                .tabItem {
                    HStack {
                        Text("Home")
                            .font(.title)
                        Image(systemName: "house.circle")
                            .font(.title)
                    }
                }
            
            WinnersView(state: state)
                .tabItem {
                    Text("Winners")
                        .font(.title)
                    Image(systemName: "trophy.circle")
                        .font(.title)
                }
            
            CharitiesView(state: state)
                .tabItem {
                    HStack {
                        Text("Donations")
                            .font(.title)
                        Image(systemName: "dollarsign.circle")
                            .font(.title)
                    }
                }
            EpisodesView(state: state)
                .tabItem {
                    HStack {
                        Text("Episodes")
                            .font(.title)
                        Image(systemName: "headphones.circle")
                            .font(.title)
                    }
                }
            
            GamesView(state: state)
                .tabItem {
                    HStack {
                        Text("Games")
                            .font(.title)
                        Image(systemName: "flag.checkered.circle")
                            .font(.title)
                    }
                }
        }
    }
    
    @ViewBuilder func buildHomeView() -> some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Text("Welcome to the Rickies!")
                    .padding()
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                    .background(content: {
                        RoundedRectangle(cornerRadius: 20)
                            .opacity(0.5)
                    })
                    .glassBackgroundEffect()
                    .shadow(radius: 20)
                    .padding3D(.back, 25)
                
                Spacer()
                
                Button {
                    showSafari.toggle()
                } label: {
                    Text("All data sourced from the excellant rickies.net API")
                        .foregroundStyle(.black)
                }
                .background(content: {
                    RoundedRectangle(cornerRadius: 20)
                        .opacity(0.5)
                })
                .sheet(isPresented: $showSafari, content: {
                    if let url = URL(string: "https://rickies.net") {
                        SafariView(url: url)
                    }
                })
                .shadow(radius: 20)
                .padding3D(.back, 25)
                .padding(.top, -80)
            }
            Spacer()
        }
    }
}

#Preview {
    ContentView(state: AppState.shared)
}
