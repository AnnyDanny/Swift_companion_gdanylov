//
//  ResultView.swift
//  swiftCompanionGdanylov
//
//  Created by Ganna DANYLOVA on 4/16/19.
//  Copyright © 2019 Ganna DANYLOVA. All rights reserved.
//

import Foundation
import UIKit



struct Result : Decodable {
//    var login: String
    var email: String?
//    var maobile: Int
//    var level : Int
    var pool_year : String?
//    var location : String
    var wallet : Int?
//    var correction : Int
    var cursus_users : [curcus]?
    
    enum CodingKeys: String, CodingKey {
//        case login
        case email = "email"
//        case mobile
//        case level
        case pool_year = "pool_year"
//        case location
        case wallet = "wallet"
        case cursus_users = "cursus_users"
//        case correction
    }
    struct Skills : Decodable {
        var level : Double;
        var name : String;
        enum CodingKeys: String, CodingKey {
            case level = "level"
            case name = "name"
        }
    }
//    var skills = [Skills]()
    struct curcus : Decodable {
        var skills : [Skills]?
        
        enum CodingKeys: String, CodingKey {
           case skills = "skills"
        }
    }
}


class ResultView : UIViewController {
    
}

//Optional(["campus_users": <__NSSingleObjectArrayI 0x60000001f130>(
//    {
//    "campus_id" = 8;
//    id = 20843;
//    "is_primary" = 1;
//    "user_id" = 30796;
//}

