//
//  LogOutUseCase.swift
//  ChatForTest
//
//  Created by Daniel Alberto Rodriguez Cielo on 05/06/25.
//

protocol AuthLogOutRepository {
    func logOut(completion: @escaping (Result<Void, Error>) -> Void)
}

class LogOutUseCase {
    private let repository: AuthLogOutRepository

    init(repository: AuthLogOutRepository) {
        self.repository = repository
    }

    func execute(completion: @escaping (Result<Void, Error>) -> Void) {
        repository.logOut(completion: completion)
    }
}
