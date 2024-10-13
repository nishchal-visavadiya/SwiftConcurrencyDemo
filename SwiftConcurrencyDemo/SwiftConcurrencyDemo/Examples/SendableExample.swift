//
//  SendableExample.swift
//  SwiftConcurrencyDemo
//
//  Created by Nishchal Visavadiya on 13/10/24.
//

import SwiftUI

struct User {
    let id: Int
    let name: String
    
    init(id: Int = 0, name: String = "Not disclosed") {
        self.id = id
        self.name = name
    }
}

final class UserDataStore: Sendable {
    
    nonisolated(unsafe) private var user = User()
    
    func updateUserData() {
        user = User(name: "Nishchal")
    }
}

class UserProfileViewModel: ObservableObject, @unchecked Sendable {
    
    let userDataStore = UserDataStore()
    
    func updateUserData() {
        Task { [weak self] in
            self?.userDataStore.updateUserData()
        }
    }
}

struct SendableExample: View {
    
    @StateObject var userProfileViewModel = UserProfileViewModel()
    
    var body: some View {
        Button("Update User Data") {
            userProfileViewModel.updateUserData()
        }
    }
}
