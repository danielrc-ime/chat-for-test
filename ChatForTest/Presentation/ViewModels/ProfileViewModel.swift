//
//  ProfileViewModel.swift
//  ChatForTest
//
//  Created by Daniel Alberto Rodriguez Cielo on 05/06/25.
//

import Foundation

class ProfileViewModel {
    private let saveUseCase: SaveUserProfileUseCase
    private let logOutUseCase: LogOutUseCase
    private let repository: UserProfileRepository
    var user: User?

    var onSuccess: (() -> Void)?
    var onError: ((String) -> Void)?
    var onProfileLoaded: ((UserProfile) -> Void)?
    var onLoggedOut: (() -> Void)?

    init(saveUseCase: SaveUserProfileUseCase, logOutUseCase: LogOutUseCase, user: User?, repository: UserProfileRepository) {
        self.saveUseCase = saveUseCase
        self.logOutUseCase = logOutUseCase
        self.repository = repository
        self.user = user
    }

    func loadProfile() {
        guard let uid = user?.uid else {
            onError?("Usuario no válido")
            return
        }

        repository.fetchUserProfile(uid: uid) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    self?.onProfileLoaded?(profile)
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }

    func saveProfile(name: String, gender: String, occupation: String) {
        guard let user = user else {
            onError?("Usuario no válido")
            return
        }

        let profile = UserProfile(
            uid: user.uid,
            email: user.email,
            name: name,
            gender: gender,
            occupation: occupation
        )

        saveUseCase.execute(profile: profile) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.onSuccess?()
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
    
    func signOut() {
        logOutUseCase.execute { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.onLoggedOut?()
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
}
