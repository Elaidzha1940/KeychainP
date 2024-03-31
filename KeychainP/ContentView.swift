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

final class KeychainManager {
    private let keychain: KeychainSwift
    
    init() {
        let keychain = KeychainSwift()
        keychain.synchronizable = true
        self.keychain = keychain
    }
    
    func set(_ value: String, key: String) {
        keychain.set(value, forKey: key)
    }
    
    func get(key: String) -> String? {
        keychain.get(key)
    }
}

struct KeychainManagerKey: EnvironmentKey {
    //
    static let defaultValue: KeychainManager = KeychainManager()
}

extension EnvironmentValues {
    var keychain: KeychainManager {
        get { self[KeychainManagerKey.self] }
        set { self[KeychainManagerKey.self] = newValue }
    }
}

struct ContentView: View {
    @Environment(\.keychain) var keychain
    //let keychainManager = KeychainManager()
    @State private var userPassword: String = ""
    
    var body: some View {
        VStack {
            Button(userPassword.isEmpty ? "No password" : userPassword) {
                let newPassword = "eli0802"
                keychain.set(newPassword, key: "user_password")
                //                keychain.keychain.set(newPassword, forKey: "user_password") // withAccess: .accessibleWhenUnlockedThisDeviceOnly
                //                userPassword = newPassword
                
                //                keychain.delete("my key")
                //                keychain.clear()
            }
            .onAppear {
                userPassword = keychain.get(key: "user_password") ?? ""
                //                userPassword = KeychainSwift().get("user_password") ?? ""
            }
        }
    }
}

#Preview {
    ContentView()
}
