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
        primaryView()
            .ornament(attachmentAnchor: .scene(alignment: .bottom)) {
                bottomNavOrnament()
                    .padding3D(.back, 25)
                    .shadow(radius: 30.0)
            }
    }
    
    @ViewBuilder func primaryView() -> some View {
        switch shownView {
        case .none:
            buildHomeView()
        case .winners:
            WinnersView(state: state)
        case .charities:
            CharitiesView(state: state)
        case .episodes:
            EpisodesView(state: state)
        case .pastGames:
            GamesView(state: state)
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
    
    @ViewBuilder func bottomNavOrnament() -> some View {
        HStack {
            Button {
                shownView = .winners
            } label: {
                HStack {
                    Text("Current Winners")
                        .font(.title)
                    Image(systemName: "trophy.circle")
                        .font(.title)
                }
                .foregroundStyle(.black)
            }
            .background(content: {
                RoundedRectangle(cornerRadius: 20)
                    .opacity(0.5)
            })
            .overlay(content: {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(shownView == .winners ? .yellow : .clear, lineWidth: 3.0)
            })
            
            Button {
                shownView = .charities
            } label: {
                HStack {
                    Text("Charitable Donations")
                        .font(.title)
                    Image(systemName: "dollarsign.circle")
                        .font(.title)
                }
                .foregroundStyle(.black)
            }
            .background(content: {
                RoundedRectangle(cornerRadius: 20)
                    .opacity(0.5)
            })
            .overlay(content: {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(shownView == .charities ? .yellow : .clear, lineWidth: 3.0)
            })
            
            Button {
                shownView = .episodes
            } label: {
                HStack {
                    Text("Episodes")
                        .font(.title)
                    Image(systemName: "headphones.circle")
                        .font(.title)
                }
                .foregroundStyle(.black)
            }
            .background(content: {
                RoundedRectangle(cornerRadius: 20)
                    .opacity(0.5)
            })
            .overlay(content: {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(shownView == .episodes ? .yellow : .clear, lineWidth: 3.0)
            })
            
            Button {
                shownView = .pastGames
            } label: {
                HStack {
                    Text("Past Games")
                        .font(.title)
                    Image(systemName: "calendar.circle")
                        .font(.title)
                }
                .foregroundStyle(.black)
            }
            .background(content: {
                RoundedRectangle(cornerRadius: 20)
                    .opacity(0.5)
            })
            .overlay(content: {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(shownView == .pastGames ? .yellow : .clear, lineWidth: 3.0)
            })
        }
    }
}

#Preview {
    ContentView(state: AppState.shared)
}
