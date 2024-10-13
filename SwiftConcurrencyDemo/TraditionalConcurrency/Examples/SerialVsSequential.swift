
import SwiftUI

class SerialVsSequential: ObservableObject {
    
    let serialQueue = DispatchQueue(label: "serialQueue")
    
    func run() {
        serialQueue.async {
            print("Task1 started")
            Thread.sleep(forTimeInterval: 3)
            print("Task1 ended")
        }
        serialQueue.async {
            print("Task2 started")
            Thread.sleep(forTimeInterval: 2)
            print("Task2 ended")
        }
        serialQueue.async {
            print("Task3 started")
            Thread.sleep(forTimeInterval: 1)
            print("Task3 ended")
        }
    }
}

struct SerialVsSequentialExampleView: View {
    
    @StateObject var serialVsSequential = SerialVsSequential()
    
    var body: some View {
        Button("Run") {
            serialVsSequential.run()
        }
    }
}
