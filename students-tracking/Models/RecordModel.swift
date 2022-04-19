//
//  RecordModel.swift
//  students-tracking
//
//  Created by Vale Delgado on 17/04/22.
//

import UIKit

class RecordModel: NSObject {
    var day: String
    var minutes: Int
    var checkin: String
    var checkout: String
    
    init(day: String, minutes: Int, checkin: String, checkout: String) {
        self.day = day
        self.minutes = minutes
        self.checkin = checkin
        self.checkout = checkout
    }
    
    func getFirebaseStructure() -> [String: Any] {
        let object: [String: Any] = [
            "day": self.day as NSObject,
            "minutes": self.minutes as NSObject,
            "checkin": self.checkin as NSObject,
            "checkout": self.checkout as NSObject
        ]
        return object
    }
}
