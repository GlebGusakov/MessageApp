//
//  User.swift
//  MessageApp
//
//  Created by Глеб Гусаков on 18/05/2019.
//  Copyright © 2019 Глеб Гусаков. All rights reserved.
//

import UIKit

class User: NSObject {
    var id: String?
    var name: String?
    var email: String?
    init(dictionary: [String: AnyObject]) {
        self.id = dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.email = dictionary["email"] as? String
    }
}
