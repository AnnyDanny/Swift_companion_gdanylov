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
    var email: String?
    var first_name : String?
    var last_name : String?
    var phone: String?
    var wallet : Int?
    var imageUrl : URL
    var cursus_users : [Curcus]?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case first_name = "first_name"
        case last_name = "last_name"
        case phone = "phone"
        case wallet = "wallet"
        case imageUrl = "image_url"
        case cursus_users = "cursus_users"
    }
    struct Skills : Decodable {
//        var levelSkills : Double;
        var name : String;
        enum CodingKeys: String, CodingKey {
//            case levelSkills = "level"
            case name = "name"
        }
    }
//    var skills = [Skills]()
    struct Curcus : Decodable {
        var grade : String?
        var skills : [Skills]?
        var level : Double?
        
        enum CodingKeys: String, CodingKey {
           case grade = "grade"
           case skills = "skills"
           case level = "level"
        }
    }
}
