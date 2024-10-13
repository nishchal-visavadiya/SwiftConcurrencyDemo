
import SwiftUI
import Synchronization

actor MyActor {
    
    private var preivousTask: Task<Int, any Error>?
    
    func doSomeWork(forId: Int, sleepForSeconds: Int) async throws -> Int {
//        preivousTask = Task { [preivousTask] in
//            let preiousValue = try await preivousTask?.value ?? 0
//            
//            return preiousValue
//        }
//        return try await preivousTask?.value ?? 0
        
        print("Task\(forId) started")
        await waitFor(sleepForSeconds: sleepForSeconds)
        print("Task\(forId) ended")
        return forId
    }
    
    func waitFor(sleepForSeconds: Int) async {
        try? await Task.sleep(for: .seconds(sleepForSeconds))
    }
}

final class SerialVsSequential: ObservableObject, Sendable {
    
    private let myActor = MyActor()
    
    func run() {
        print(Task.currentPriority.rawValue)
        print(TaskPriority.userInitiated.rawValue)
        print(TaskPriority.high.rawValue)
        print(TaskPriority.medium.rawValue)
        print(TaskPriority.low.rawValue)
        print(TaskPriority.utility.rawValue)
        print(TaskPriority.background.rawValue)
        Task { [weak self] in
            try await self?.myActor.doSomeWork(forId: 1, sleepForSeconds: 3)
        }
        Task { [weak self] in
            try await self?.myActor.doSomeWork(forId: 2, sleepForSeconds: 2)
        }
        Task { [weak self] in
            try await self?.myActor.doSomeWork(forId: 3, sleepForSeconds: 1)
        }
    }
}

struct TaskExampleView: View {
    
    @StateObject var serialVsSequential = SerialVsSequential()
    
    var body: some View {
        Button("Run") {
            serialVsSequential.run()
        }
    }
}
