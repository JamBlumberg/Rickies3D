import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @StateObject var state = AppState.shared
    @State var showSafari: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    enum ShownView {
        case none, winners, charities, episodes, pastGames
    }
    
    @State var shownView: ShownView = .none
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                primaryView()
                    .ornament(attachmentAnchor: .scene(alignment: .bottom)) {
                        VStack {
                            Spacer()
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
                            .padding3D(.back, 25)
                            .shadow(radius: 30.0)
                        }
                    }
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
    
    @ViewBuilder func primaryView() -> some View {
        switch shownView {
        case .none:
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
    
    @ViewBuilder func nav() -> some View {
        VStack {
            Spacer()
            NavigationLink(destination: {
                WinnersView(state: state)
            }) {
                HStack {
                    Text("Current Winners")
                        .font(.title)
                    Image(systemName: "trophy.circle")
                        .font(.title)
                }
            }
            NavigationLink(destination: {
                CharitiesView(state: state)
            }) {
                HStack {
                    Text("Charitable Donations")
                        .font(.title)
                    Image(systemName: "dollarsign.circle")
                        .font(.title)
                }
            }
            NavigationLink(destination: {
                EpisodesView(state: state)
            }) {
                HStack {
                    Text("Episodes")
                        .font(.title)
                    Image(systemName: "headphones.circle")
                        .font(.title)
                }
            }
            // Unused for now as Bill Changes are formatted in HTML with internal links to other areas on rickies.net, which is non-trivial to resolve in the app
//                NavigationLink(destination: {
//                    BillChangesView(state: state)
//                }) {
//                    Text("Changes to the Bill of Rickies")
//                        .font(.title)
//                }
            NavigationLink(destination: {
                GamesView(state: state)
            }) {
                HStack {
                    Text("Past Games")
                        .font(.title)
                    Image(systemName: "calendar.circle")
                        .font(.title)
                }
            }
            Spacer()
            Button {
                showSafari.toggle()
            } label: {
                Text("All data sourced from the excellant rickies.net API")
            }.sheet(isPresented: $showSafari, content: {
                if let url = URL(string: "https://rickies.net") {
                    SafariView(url: url)
                }
            })
            .padding()
        }
        .navigationTitle("The Rickies")
    }
}

#Preview {
    ContentView(state: AppState.shared)
}
