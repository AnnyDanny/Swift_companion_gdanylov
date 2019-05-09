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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var enterLogin: UITextField!
    
    @IBAction func searchButton(_ sender: UIButton) {
        //activityIndicator.isHidden = true
        //activityIndicator.startAnimating()
        self.getLogin()
    }
    
    var getToken = GetToken()
    var res : Result?
    let downloadGroup = DispatchGroup()
    
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
                        self.getToken.token = get["access_token"] as? String
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
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let urlLogin = "https://api.intra.42.fr/v2/users/"
        let urlPath: String = urlLogin + login!
        if let url = URL(string: urlPath) {
            if let request: NSMutableURLRequest = NSMutableURLRequest(url: url) {
                request.httpMethod = "GET"
                if getToken.token != nil {
                    DispatchQueue.global(qos: .userInitiated).async {
                        request.setValue("Bearer " + self.getToken.token!, forHTTPHeaderField: "Authorization")
                        let session = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                            if let response = response {
                                print(response)
                            }
                            guard let data = data else { return }
                            do {
                                let jsonResult = (try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any>)
                                let decoder = JSONDecoder()
                                let result = try? decoder.decode(Result.self, from: data)
                                print("\nresult--->>>\n")
                                self.res = result
                                DispatchQueue.main.async {
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let controller = storyboard.instantiateViewController(withIdentifier: "Student") as! Student
                                    controller.res = self.res
                                    self.navigationController?.pushViewController(controller, animated: true)
                                }
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
            else {
                makeAlert()
                print("\nError request\n")
            }
        }
        else {
            makeAlert()
            print("\nError URL\n")
        }

//        if getToken.token != nil {
//            DispatchQueue.global(qos: .userInitiated).async {
//                request.setValue("Bearer " + self.getToken.token!, forHTTPHeaderField: "Authorization")
//                let session = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
//                    if let response = response {
//                        print(response)
//                    }
//                    guard let data = data else { return }
//                    do {
//                        let jsonResult = (try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any>)
//                        let decoder = JSONDecoder()
//                        let result = try? decoder.decode(Result.self, from: data)
//                        print("\nresult--->>>\n")
//                        self.res = result
//                        DispatchQueue.main.async {
//                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                            let controller = storyboard.instantiateViewController(withIdentifier: "Student") as! Student
//                            controller.res = self.res
//                            self.navigationController?.pushViewController(controller, animated: true)
//                        }
//                    }
//                    catch {
//                        print("\nERROR in DO----->>>>>\n")
//                        print(error)
//                    }
//                }
//                session.resume()
//            }
//        }
    }
    func makeAlert() {
        let alert = UIAlertController(title: "Error", message: "This login is not existent", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

//            request.setValue("Bearer " + getToken.token!, forHTTPHeaderField: "Authorization")
//            let session = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
//                if let response = response {
//                    print("Response--->>>\n")
//                    print(response)
//                }
//                guard let data = data else { return }
//                do {
//                    let jsonResult = (try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any>)
//                    let decoder = JSONDecoder()
//                    let result = try? decoder.decode(Result.self, from: data)
////                    sendRes(data: result)
////                    print("\n\n\n\n\nres_first-------->>>>\n\n\n\n")
////                    print(result?.first_name)
////                    print(res.first_name)
//                    print("\n\n\n\n\n")
////                    self.res.append(Result(firs: (author["login"] as? String)! , data: (value["created_at"] as? String)!, msgUrl: (value["messages_url"] as? String)!))
//                    print("\nresult--->>>\n")
//                    print(result)
//                    print("\n\n\n\n\n\n\n\n\n\n\n")
//                        print("\njsonResult----->>>>>\n")
//                        print(jsonResult)
////                      DispatchQueue.main.async {
////                        }
//                }
//                catch {
//                    print("\nERROR in DO----->>>>>\n")
//                    print(error)
//                }
//            }
//            session.resume()
//        }
//    }
//}
//    func sendRes(data: MyData) {
//        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            (segue.destination as? Student)?.firstNameLabel.text =
//
//        }
//    }
//}
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.destination is Student {
//            let vc = segue.destination as? Student
//            vc?.firstNameLabel =
//        }
//    }
//}

//extension ViewController {
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        (segue.destination as? Student)?.firstNameLabel.text = self.res?.first_name
//        (segue.destination as? Student)?.msgUrl = self.msgUrl
        
//    }
//}

//override func prepare(for segue: UIStoryboardSegue, sender: Any?)
//{
//    if segue.destination is TertiaryViewController
//    {
//        let vc = segue.destination as? TertiaryViewController
//        vc?.username = "Arthur Dent"
//    }
//}

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

