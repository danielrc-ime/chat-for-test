//
//  FirebaseAuthRepository.swift
//  ChatForTest
//
//  Created by Daniel Alberto Rodriguez Cielo on 05/06/25.
//


import FirebaseAuth

class FirebaseAuthRepository: AuthRepository, AuthLogOutRepository {
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let firebaseUser = result?.user {
                let user = User(uid: firebaseUser.uid, email: firebaseUser.email ?? "")
                completion(.success(user))
            }
        }
    }
    
    func register(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                debugPrint(error)
                completion(.failure(error))
            } else if let firebaseUser = result?.user {
                let user = User(uid: firebaseUser.uid, email: firebaseUser.email ?? "")
                completion(.success(user))
            }
        }
    }
    
    func logOut(completion: @escaping (Result<Void, any Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }

}
