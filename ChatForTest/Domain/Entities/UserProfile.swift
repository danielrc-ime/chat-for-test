//
//  UserProfile.swift
//  ChatForTest
//
//  Created by Daniel Alberto Rodriguez Cielo on 05/06/25.
//


struct UserProfile {
    let uid: String
    var email: String
    var name: String
    var gender: String
    var occupation: String

    func toDictionary() -> [String: Any] {
        return [
            "uid": uid,
            "email": email,
            "name": name,
            "gender": gender,
            "occupation": occupation
        ]
    }
}
