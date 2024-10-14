
import SwiftUI

actor BankAccount {
    
    let accountNumber: String
    private var balance: Double = 0.0
    
    init(accountNumber: String) {
        self.accountNumber = accountNumber
    }
    
    func deposit(_ amount: Double) {
        print("Start deposit of \(amount)")
        balance += amount
        print("Deposit complete. New balance: \(balance)")
    }
    
    func withdraw(_ amount: Double) {
        print("Start withdrawal of \(amount)")
        guard balance >= amount else {
            print("Insufficient funds!")
            return
        }
        balance -= amount
        print("Withdrawal complete. New balance: \(balance)")
        return
    }
    
    nonisolated func printAccountNumber() {
        print("Account number: \(accountNumber)")
    }
}

final class ViewModel: ObservableObject, Sendable {
    
    private let account = BankAccount(accountNumber: "123456")
    
    func run() {
        Task {
            await account.deposit(100)
        }
        account.printAccountNumber()
        Task {
            await account.withdraw(50)
        }
    }
}
