//
//  MockAuthRepository.swift
//  ChatForTest
//
//  Created by Daniel Alberto Rodriguez Cielo on 05/06/25.
//


// MARK: - Mock Implementaciones
@testable import ChatForTest
import Foundation

class MockAuthRepository: AuthRepository {
    var shouldLoginSucceed = true
    var shouldRegisterSucceed = true
    var currentUser: User? = nil

    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        if shouldLoginSucceed {
            let user = User(uid: "mockUID", email: email)
            currentUser = user
            completion(.success(user))
        } else {
            completion(.failure(NSError(domain: "LoginError", code: 401, userInfo: nil)))
        }
    }

    func register(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        if shouldRegisterSucceed {
            let user = User(uid: "mockUID", email: email)
            currentUser = user
            completion(.success(user))
        } else {
            completion(.failure(NSError(domain: "RegisterError", code: 500, userInfo: nil)))
        }
    }

    func logout() throws {
        currentUser = nil
    }
}

class MockUserProfileRepository: UserProfileRepository {
    
    var storedProfiles: [String: UserProfile] = [:]

    func saveUserProfile(_ profile: UserProfile, completion: @escaping (Result<Void, Error>) -> Void) {
        storedProfiles[profile.uid] = profile
        completion(.success(()))
    }

    func fetchUserProfile(uid: String, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        completion(.success(storedProfiles[uid]!))
    }
}
