//
//  ViewController.swift
//  swiftCompanionGdanylov
//
//  Created by Ganna DANYLOVA on 4/16/19.
//  Copyright © 2019 Ganna DANYLOVA. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var enterLogin: UITextField!
    
    @IBAction func searchButton(_ sender: UIButton) {
        print("Button is good")
        self.performSegue(withIdentifier: "toStudentView", sender: self)
        getLogin()
    }
    
    var getToken = GetToken()
    var res: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View has loaded")
        autorizationToken()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func autorizationToken() {
        let bearer = ((getToken.client_id + ":" + getToken.client_secret).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions())
        let url = URL(string: "https://api.intra.42.fr/oauth/token")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("Basic " + bearer, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if data != nil {
                do {
                    if let get : NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        print("\nGet---->>>>\n")
                        print(get)
                        self.getToken.token = get["access_token"] as? String
                        
                        print("\nToken--->>>>>\n")
                        print(self.getToken.token as Any)
                    }
                }
                catch (let error) {
                    print("\nerror--->>>>\n")
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func getLogin() {
        let login = enterLogin.text
        let urlLogin = "https://api.intra.42.fr/v2/users/"
        print("\nStarted get login---->>>>>\n")
        let urlPath: String = urlLogin + login!
//        let urlPath: String = "https://cdn.intra.42.fr/users/gdanylov.jpg"
        let url = URL(string: urlPath)
        let request: NSMutableURLRequest = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        if getToken.token != nil {
            request.setValue("Bearer " + getToken.token!, forHTTPHeaderField: "Authorization")
            let session = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                if let response = response {
                    print("Response--->>>\n")
//                    print(response)
                }
                guard let data = data else { return }
                do {
                    let jsonResult = (try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any>)
                    let decoder = JSONDecoder()
                    let result = try? decoder.decode(Result.self, from: data)
                    print("\nresult--->>>\n")
                    print(result)
                    print("\n\n\n\n\n\n\n\n\n\n\n")
                        print("\njsonResult----->>>>>\n")
                        print(jsonResult)
//                      DispatchQueue.main.async {
//                        }
                }
                catch {
                    print("\nERROR in DO----->>>>>\n")
                    print(error)
                }
            }
            session.resume()
        }
    }
}
    
//    func sendResult() {
//        DispatchQueue.main.async {
//            let storyboard = UIStoryboard(name: "ViewController", bundle: nil)
//            let controller = storyboard.instantiateViewController(withIdentifier: "Student") as! Student
//            controller.res = self.result
//        }
//    }
//
//}



//func checkAPIResponse() {
//    DispatchQueue.main.async {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "studentInfo") as! StudentInfoViewController
//        controller.userData = self.studentInfo
//        self.navigationController?.pushViewController(controller, animated: true)
//    }
//
//}

