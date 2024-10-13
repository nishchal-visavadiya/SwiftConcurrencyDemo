
import Foundation
@preconcurrency import Alamofire

actor SomeDataManager {
    
    // Using async/await to fetch, process, and save data
    func syncData() async {
        do {
            let data = try await fetchData()
            let processedData = try await process(data)
            try await save(processedData)
            print("All operations completed successfully!")
        } catch {
            // Handle appropriate errors
            print("Error occurred: \(error.localizedDescription)")
        }
    }
    
    // Simulating async function to fetch data
    private func fetchData() async throws -> Data? {
        // Simulating network delay
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        // Simulating network fetch
        let success = Bool.random()
        if success {
            let data = await AF.request("https://httpbin.org/get").serializingData().response.data
            return data
        } else {
            throw NSError(domain: "FetchError", code: 1, userInfo: nil)
        }
    }
    
    // Simulating async function to process data
    private func process(_ data: Data?) async throws -> Data {
        guard let data else {
            throw NSError(domain: "ProcessError", code: 5, userInfo: nil)
        }
        // Simulating processing delay
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        let success = Bool.random()
        if success {
            return Data(data.reversed()) // Simulated data processing (reversing)
        } else {
            throw NSError(domain: "ProcessError", code: 2, userInfo: nil)
        }
    }
    
    // Simulating async function to save data
    private func save(_ data: Data) async throws {
        // Simulating save delay
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        let success = Bool.random()
        if success {
            print("Data saved: \(data)")
        } else {
            throw NSError(domain: "SaveError", code: 3, userInfo: nil)
        }
    }
}
