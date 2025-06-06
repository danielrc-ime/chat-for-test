//
//  AuthRepository.swift
//  ChatForTest
//
//  Created by Daniel Alberto Rodriguez Cielo on 05/06/25.
//


protocol AuthRepository {
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func register(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
}

class LoginUseCase {
    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }

    func execute(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        repository.login(email: email, password: password, completion: completion)
    }
}
