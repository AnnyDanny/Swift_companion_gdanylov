//
//  ViewController.swift
//  swiftCompanionGdanylov
//
//  Created by Ganna DANYLOVA on 4/16/19.
//  Copyright © 2019 Ganna DANYLOVA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func searchButton(_ sender: UIButton) {
        print("Button is good")
        self.performSegue(withIdentifier: "toResultView", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View has loaded")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

