//
//  UserProfileRepository.swift
//  ChatForTest
//
//  Created by Daniel Alberto Rodriguez Cielo on 05/06/25.
//


protocol UserProfileRepository {
    func saveUserProfile(_ profile: UserProfile, completion: @escaping (Result<Void, Error>) -> Void)
    func fetchUserProfile(uid: String, completion: @escaping (Result<UserProfile, Error>) -> Void)
}

class SaveUserProfileUseCase {
    private let repository: UserProfileRepository

    init(repository: UserProfileRepository) {
        self.repository = repository
    }

    func execute(profile: UserProfile, completion: @escaping (Result<Void, Error>) -> Void) {
        repository.saveUserProfile(profile, completion: completion)
    }
}
