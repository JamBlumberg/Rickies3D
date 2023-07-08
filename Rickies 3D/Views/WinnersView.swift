import SwiftUI

struct WinnersView: View {
    @ObservedObject var state: AppState
    
    var body: some View {
        VStack {
            Text("Current Winners")
                .font(.largeTitle)
            HStack {
                if let winners = state.winners {
                    List {
                        Section {
                            VStack  {
                                HStack {
                                    Spacer()
                                    Text("\(winners.annual.winner) the \(winners.annual.title)")
                                    Spacer()
                                }.listRowSeparator(.hidden, edges: .all)
                                HStack {
                                    Spacer()
                                    Text(winners.annual.gameName)
                                    Spacer()
                                }.listRowSeparator(.hidden, edges: .all)
                                HStack {
                                    Spacer()
                                    Text(winners.annual.date)
                                    Spacer()
                                }.listRowSeparator(.hidden, edges: .all)
                                HStack {
                                    Spacer()
                                    Text(winners.annual.social)
                                    Spacer()
                                }.listRowSeparator(.hidden, edges: .all)
                            }
                        }
                    header: {
                        Text("Annual:")
                            .font(.title)
                    }
                    }
                    List {
                        Section {
                            VStack {
                                HStack {
                                    Spacer()
                                    Text("\(winners.keynote.winner) the \(winners.keynote.title)")
                                    Spacer()
                                }.listRowSeparator(.hidden, edges: .all)
                                HStack {
                                    Spacer()
                                    Text(winners.keynote.gameName)
                                    Spacer()
                                }.listRowSeparator(.hidden, edges: .all)
                                HStack {
                                    Spacer()
                                    Text(winners.keynote.date)
                                    Spacer()
                                }.listRowSeparator(.hidden, edges: .all)
                                HStack {
                                    Spacer()
                                    Text(winners.keynote.social)
                                    Spacer()
                                }.listRowSeparator(.hidden, edges: .all)
                            }
                        } header: {
                        Text("Keynote:")
                            .font(.title)
                    }
                    }
                }
            }
            
            if let winners = state.winners {
                HStack {
                    Spacer()
                        .frame(maxWidth: .infinity)
                    List {
                        Section {
                            VStack {
                                HStack {
                                    Spacer()
                                    Text("\(winners.flexies.winner) the \(winners.flexies.title)")
                                    Spacer()
                                }.listRowSeparator(.hidden, edges: .all)
                                HStack {
                                    Spacer()
                                    Text(winners.flexies.gameName)
                                    Spacer()
                                }.listRowSeparator(.hidden, edges: .all)
                                HStack {
                                    Spacer()
                                    Text(winners.flexies.date)
                                    Spacer()
                                }.listRowSeparator(.hidden, edges: .all)
                            }
                        } header: {
                            Text("Flexies:")
                                .font(.title)
                        }
                    }
                    Spacer()
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .foregroundStyle(.black)
        .task {
            do {
                try await WinnersFetcher.fetchWinners()
            } catch {
                print("Error fetching winners")
            }
        }

    }
}

#Preview {
    WinnersView(state: AppState.shared)
}
