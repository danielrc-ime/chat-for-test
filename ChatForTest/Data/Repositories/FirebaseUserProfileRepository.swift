//
//  FirebaseUserProfileRepository.swift
//  ChatForTest
//
//  Created by Daniel Alberto Rodriguez Cielo on 05/06/25.
//


import FirebaseFirestore
import FirebaseAuth

class FirebaseUserProfileRepository: UserProfileRepository {
    
    private let db = Firestore.firestore()
    
    func saveUserProfile(_ profile: UserProfile, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("users").document(profile.uid).setData(profile.toDictionary()) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func fetchUserProfile(uid: String, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        db.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = snapshot?.data() {
                let profile = UserProfile(
                    uid: uid,
                    email: data["email"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    gender: data["gender"] as? String ?? "",
                    occupation: data["occupation"] as? String ?? ""
                )
                completion(.success(profile))
            } else {
                completion(.failure(NSError(domain: "Firestore", code: 404, userInfo: [NSLocalizedDescriptionKey: "Perfil no encontrado."])))
            }
        }
    }
}
