//
//  UserModel.swift
//  Assignment4
//
//  Created by user269971 on 3/24/25.
//

import Foundation
import FirebaseAuth

class UserModel {
    var id: String
    var email: String
    
    init(id: String, email: String) {
        self.id = id
        self.email = email
    }
    
    static func currentUser() -> UserModel? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }
        return UserModel(id: user.uid, email: user.email ?? "")
    }
}
