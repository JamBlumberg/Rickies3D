import SwiftUI
import HTML2Markdown

struct BillChangesView: View {
    @ObservedObject var state: AppState
    @State var searchText: String = ""
    var body: some View {
        VStack {
            List {
                ForEach(searchResults, id: \.hashValue) { result in
                    Section {
                        Text(convertHTMLToMarkdown(result.changes))
                    } header: {
                        Text("Episode \(result.episode)")
                    }
                }
            }
        }
        .navigationTitle("Bill Changes")
        .task {
            do {
                try await BillChangesFetcher.fetchBillChanges()
            } catch {
                print("error fetching bill changes")
            }
        }
    }
    
    var searchResults: [BillChange] {
        if searchText.isEmpty {
            return state.billChanges ?? []
        } else {
            if let billChanges = state.billChanges {
                return billChanges.filter { 
                    String($0.episode).contains(searchText) || $0.changes.contains(searchText)
                }
            } else {
                return []
            }
        }
    }
    
    func convertHTMLToMarkdown(_ string: String) -> String {
        do {
            let dom = try HTMLParser().parse(html: string)
            let markdown = dom.toMarkdown(options: .unorderedListBullets)
            return markdown
        } catch {
            print("error converting to markdown")
            return ""
        }
    }
}

#Preview {
    BillChangesView(state: AppState.shared)
}
