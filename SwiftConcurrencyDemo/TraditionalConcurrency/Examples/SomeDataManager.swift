
import Foundation

class SomeDataManager {
    
    private let myQueue = DispatchQueue(label: "com.myQueue")
    
    func syncData() {
        fetchData { result in
            switch result {
            case .success(let data):
                self.process(data) { [self] processedResult in
                    switch processedResult {
                    case .success(let success):
                        self.save(success) { saveResult in
                            // More nesting...
                        }
                    case .failure(let failure):
                        handleError(failure)
                    }
                }
            case .failure(let error):
                self.handleError(error)
            }
        }
    }
    
    // Demo of the fetchData function that takes a completion handler
    private func fetchData(completion: @escaping (Result<Data, Error>) -> Void) {
        myQueue.async {
            // Simulating network fetch
            let success = Bool.random() // Randomly succeed or fail
            if success {
                let data = Data("Sample data".utf8) // Simulating fetched data
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "FetchError", code: 1, userInfo: nil)))
            }
        }
    }
    
    // Demo of the process function
    private func process(_ data: Data, completion: @escaping (Result<Data, Error>) -> Void) {
        myQueue.async {
            // Simulating data processing
            let success = Bool.random()
            if success {
                let processedData = Data(data.reversed()) // Simple processing: reversing the data
                completion(.success(processedData))
            } else {
                completion(.failure(NSError(domain: "ProcessError", code: 2, userInfo: nil)))
            }
        }
    }
    
    // Demo of the save function
    private func save(_ data: Data, completion: @escaping (Result<Void, Error>) -> Void) {
        myQueue.async {
            // Simulating saving data to disk
            let success = Bool.random()
            if success {
                print("Data saved: \(data)")
                completion(.success(())) // Success with no return value
            } else {
                completion(.failure(NSError(domain: "SaveError", code: 3, userInfo: nil)))
            }
        }
    }
    
    // Demo of the handleError function
    private func handleError(_ error: Error) {
        print("Error occurred: \(error.localizedDescription)")
    }
    
    private func fetchDataFromServer() throws -> Data {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        let data = try Data(contentsOf: url)
        return data
    }
}
