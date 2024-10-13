//
//  LegacyAPIs.swift
//  SwiftConcurrencyDemo
//
//  Created by Nishchal Visavadiya on 13/10/24.
//

import Foundation
import Combine

final class LegacyAPIs: Sendable {
    
    func foo() {
        Task {
            await operation()
        }
    }
    
    func operation() async {
        print("Operation started")
        let result = try? await getResultAsync()
        print("Operation completed")
    }
    
    func getResultAsync() async throws -> Int {
        return try await withCheckedThrowingContinuation { [weak self] continuation in
            self?.getResult() { result in
                switch result {
                case .success(let success):
                    continuation.resume(returning: success)
                case .failure(let failure):
                    continuation.resume(throwing: failure)
                }
            }
        }
    }
    
    func getResult(completion: @escaping (Result<Int, Error>) -> Void) {
        completion(.success(1))
    }
}

extension Task {
    
    func store(in set: inout Set<AnyCancellable>) {
        set.insert(AnyCancellable(cancel))
    }
}
