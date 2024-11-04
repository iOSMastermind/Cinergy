//
//  AuthViewModel.swift
//  Cinergy
//
//  Created by Jinu on 24/08/2024.
//

import Foundation

class AuthViewModel: ObservableObject {
    private var authService: AuthServiceProtocol

    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User?

    // Initialize with the service
    init(authService: AuthServiceProtocol) {
        self.authService = authService
        let defaults = UserDefaults.standard
        let token = defaults.object(forKey: "jsonwebtoken")
        if token != nil {
            isAuthenticated = true
            guestLogin()
        } else {
            isAuthenticated = false
        }
    }

    func guestLogin() {
        let defaults = UserDefaults.standard
        authService.guestLogin { [weak self] result in
            switch result {
            case .success(let data):
                guard let user = try? JSONDecoder().decode(User.self, from: data!) else { return }
                DispatchQueue.main.async {
                    defaults.setValue(user.token, forKey: "jsonwebtoken")
                    self?.isAuthenticated = true
                    self?.currentUser = user
                    print("logged in")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func logout() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
    }
}
