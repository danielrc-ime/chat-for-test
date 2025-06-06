//
//  RegisterUseCase.swift
//  ChatForTest
//
//  Created by Daniel Alberto Rodriguez Cielo on 05/06/25.
//


class RegisterUseCase {
    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }

    func execute(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        repository.register(email: email, password: password, completion: completion)
    }
}
