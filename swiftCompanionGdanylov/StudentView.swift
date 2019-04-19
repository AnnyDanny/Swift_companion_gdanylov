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
//        setRes()
//        firstNameLabel.text = res.first
    }
    
//    func setRes() {
//        firstNameLabel.text = res.fi
//    }
}
