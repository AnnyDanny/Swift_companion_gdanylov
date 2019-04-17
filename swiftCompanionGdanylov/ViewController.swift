//
//  ViewController.swift
//  swiftCompanionGdanylov
//
//  Created by Ganna DANYLOVA on 4/16/19.
//  Copyright © 2019 Ganna DANYLOVA. All rights reserved.
//

import UIKit

//var getToken = GetToken()

class ViewController: UIViewController {

    @IBAction func searchButton(_ sender: UIButton) {
        print("Button is good")
        self.performSegue(withIdentifier: "toResultView", sender: self)
    }
    
    var getToken = GetToken()
    var res: [result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View has loaded")
        autorizationToken()
//        getLogin()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func autorizationToken() {
//        var tokenInner = ""
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
            self.getLogin()
        }
        task.resume()
//        getLogin()
    }
    
    func getLogin() {
        print("\nStarted get login---->>>>>\n")
//        let urlPath: String = "https://profile.intra.42.fr/users/vlikhotk"
        let urlPath: String = "https://api.intra.42.fr/v2/users/vlikhotk"
//        let urlPath: String = "https://api.intra.42.fr/v2/topics"
        let url = URL(string: urlPath)
        let request: NSMutableURLRequest = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        if getToken.token != nil {
            request.setValue("Bearer " + getToken.token!, forHTTPHeaderField: "Authorization")
            let session = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                if let response = response {
                    print("Response--->>>\n")
                    print(response)
                }
                guard let data = data else { return }
                do {
                    let jsonResult = (try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any>)
//                    let jsonResult = (try JSONSerialization.jsonObject(with: data, options: []) as? NSMutableArray)!
//                    if let json : [NSDictionary] = (try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any>, {
                        print("\njsonResult----->>>>>\n")
                        print(jsonResult)
//                      DispatchQueue.main.async {
//                          for value in json {
//                              let login: NSDictionary = (value["login"] as? NSDictionary)!
//                                self.res.append(result(login: (author["login"] as? String)! , data: (value["created_at"] as? String)!))
//                          }
//                            self.res.reloadData()
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

//I tried responseString instead of responseJSON
//.responseString()
//Alamofire.request(.GET, "url").authenticate(user: "", password: "").responseJSON() {
//    (request, response, json, error) in
//    println(error)
//    println(json)
//
//}

