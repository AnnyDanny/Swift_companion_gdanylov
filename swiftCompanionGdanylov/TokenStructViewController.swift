//
//  TokenStructViewController.swift
//  swiftCompanionGdanylov
//
//  Created by Ganna DANYLOVA on 4/17/19.
//  Copyright © 2019 Ganna DANYLOVA. All rights reserved.
//

import Foundation
import UIKit


struct GetToken {
    let client_id = "9d700cc988a95ddcaddd76a106c78d9069c38845cb82363c75ba984702c0a1bf"
    let client_secret = "b01b060d553d0da7d130477577c49a341df84e237403ae7fa06b12226d01c02c"
    var code_s = "fd0847dbb559752d932dd3c1ac34ff98d27b11fe2fea5a864f44740cd7919ad0"
    var token : String?
}

//extension Tweet: CustomStringConvertible {
//    var description: String {
//        return "\(name), \(desc), \(date)"
//    }
//}

class TokenStructViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.dataSource = self
//        tableView.delegate = self
//        textField.text = "scholl 42"
//        textField.delegate = self as? UITextFieldDelegate
//        textField.returnKeyType = .done
//        //        let vika = Tweet(name : "vika", desc : "vika", date: "vika")
//        //        data.append(vika)
//        autorizationRequest()
//        // Do any additional setup after loading the view, typically from a nib.
    }
}
