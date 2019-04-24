//
//  ProjectTableViewCell.swift
//  swiftCompanionGdanylov
//
//  Created by Ganna DANYLOVA on 4/24/19.
//  Copyright © 2019 Ganna DANYLOVA. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var nameProject: UILabel!
    
    @IBOutlet weak var statusProject: UILabel!
    
    @IBOutlet weak var markProject: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
