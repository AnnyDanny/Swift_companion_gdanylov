//
//  StudentView.swift
//  swiftCompanionGdanylov
//
//  Created by Ganna DANYLOVA on 4/19/19.
//  Copyright © 2019 Ganna DANYLOVA. All rights reserved.
//

import Foundation
import UIKit

class Student : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var res : Result?
    
    @IBOutlet weak var projectView: UITableView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        projectView.delegate = self
        projectView.dataSource = self
        let nib = UINib.init(nibName: "ProjectTableViewCell", bundle: nil)
        self.projectView.register(nib, forCellReuseIdentifier: "ProjectTableViewCell")
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (res?.projects?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectTableViewCell", for: indexPath) as! ProjectTableViewCell
        cell.nameProject.text = res?.projects?[indexPath.section].projectName.name
        cell.statusProject.text = res?.projects?[indexPath.section].status
//        cell.markProject.text = res?.projects?[indexPath.section].final_mark
        if let finalMark = res?.projects?[indexPath.section].final_mark {
            cell.markProject.text = String(describing: finalMark)
        }
        return cell
    }
//    let cell = tableView.dequeueReusableCell(withIdentifier: "projectSectionName", for: indexPath) as! ProjectsHeaderTableViewCell
//    cell.projectSectionName.text = userData?.validatedProjects?[indexPath.section].projectNameStruct.name
    
}
