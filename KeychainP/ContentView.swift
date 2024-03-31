//  /*
//
//  Project: KeychainP
//  File: ContentView.swift
//  Created by: Elaidzha Shchukin
//  Date: 30.03.2024
//
//  */

import SwiftUI
import KeychainSwift

// Keychain is similar to UserDefaults or AppStorage
// Keychain is encrypted
// Keychain is good for: passwords, ssn, credit card info, sensitive data
// Keychain persists between installs and across devices

struct ContentView: View {
    let keychain = KeychainSwift()
    @State private var userPassword: String = ""
    
    var body: some View {
        VStack {
            Button(userPassword.isEmpty ? "No password" : userPassword) {
                let newPassword = "eli0802"
                keychain.set(newPassword, forKey: "user_password") // withAccess: .accessibleWhenUnlockedThisDeviceOnly
                userPassword = newPassword
            }
            .onAppear {
                userPassword = keychain.get("user_password") ?? ""
            }
        }
    }
}

#Preview {
    ContentView()
}
