//
//  UserModel.swift
//  students-tracking
//
//  Created by Vale Delgado on 16/04/22.
//

import UIKit

class UserModel: NSObject {
    var name: String
    var id: String
    
    init(name: String, id: String) {
        self.name = name
        self.id = id
    }
    
    func getFirebaseStructure() -> [String: Any] {
        let object: [String: Any] = [
            "name": self.name as NSObject,
            "id": self.id as NSObject
        ]
        return object
    }
}
