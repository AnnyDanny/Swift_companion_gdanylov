//
//  StudentView.swift
//  swiftCompanionGdanylov
//
//  Created by Ganna DANYLOVA on 4/19/19.
//  Copyright © 2019 Ganna DANYLOVA. All rights reserved.
//

import Foundation
import UIKit

class Student : UIViewController {
    
    var res : Result?
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRes()
    }
    
    func setRes() {
        let dataImage = try? Data(contentsOf: (res?.imageUrl)!)
        if dataImage != nil {
            imageView.image = UIImage(data: (dataImage)!)
        }
        firstNameLabel.text = res?.first_name
        lastNameLabel.text = res?.last_name
        phoneLabel.text = res?.phone
        emailLabel.text = res?.email
        if let cursusUsers = res?.cursus_users, cursusUsers.count > 0 {
            if let grade = cursusUsers[0].grade {
                gradeLabel.text = grade
            }
            else {
                gradeLabel.text = "Not graded"
            }
            if let level = cursusUsers[0].level {
                levelLabel.text = "\(String(describing: level))"
            }
        }
        else {
            gradeLabel.text = "Not graded"
            levelLabel.text = "0.0."
        }
    }
}
