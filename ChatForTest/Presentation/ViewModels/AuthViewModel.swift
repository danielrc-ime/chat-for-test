//
//  AuthViewModel.swift
//  ChatForTest
//
//  Created by Daniel Alberto Rodriguez Cielo on 05/06/25.
//

import Foundation

class AuthViewModel {
    private let loginUseCase: LoginUseCase
    private let registerUseCase: RegisterUseCase

    var onSuccess: ((User) -> Void)?
    var onError: ((String) -> Void)?

    init(loginUseCase: LoginUseCase, registerUseCase: RegisterUseCase) {
        self.loginUseCase = loginUseCase
        self.registerUseCase = registerUseCase
    }

    func login(email: String, password: String) {
        loginUseCase.execute(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.handle(result)
            }
        }
    }

    func register(email: String, password: String) {
        registerUseCase.execute(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.handle(result)
            }
        }
    }

    private func handle(_ result: Result<User, Error>) {
        switch result {
        case .success(let user):
            onSuccess?(user)
        case .failure(let error):
            onError?(error.localizedDescription)
        }
    }
}
