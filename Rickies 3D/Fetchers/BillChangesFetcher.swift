import Foundation

struct BillChangesFetcher {
    enum BillChangesFetcherError: Error {
        case invalid
        case missingData
    }
    
    @MainActor
    static func fetchBillChanges() async throws {
        guard let url = URL(string: "https://rickies.net/api/v1/billchanges.json") else {
            throw BillChangesFetcherError.invalid
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        do {
            let billChangesResult = try decoder.decode([BillChange].self, from: data)
            AppState.shared.billChanges = billChangesResult
        } catch {
            throw BillChangesFetcherError.missingData
        }
    }
}
