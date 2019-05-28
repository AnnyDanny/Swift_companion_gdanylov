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
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        self.getLogin()
    }
    
    var getToken = GetToken()
    var res : Result?
    let downloadGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        print("View has loaded")
        autorizationToken()
//        getAnim()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.isHidden = true
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
    }
    
    func getAnim() {
        let containerView = UIView(
            frame: CGRect(x: 10.0, y: 10.0, width: 375.0, height: 667.0)
        )
        containerView.backgroundColor = UIColor.black
        let appleImage = UIImageView(
            frame: CGRect(x: 10.0, y: 10.0, width: 50.0, height: 60.0)
        )
        appleImage.image = UIImage(named: "42_school")
        containerView.addSubview(appleImage)
        
        let circle = UIView(
            frame: CGRect(x: 0.0, y: 0.0, width: 64.0, height: 64.0)
        )
        circle.center = containerView.center
        circle.backgroundColor = UIColor.blue
        circle.layer.borderColor = UIColor.blue.cgColor
        circle.layer.cornerRadius = 32.0
        circle.layer.borderWidth = 2.0
        containerView.addSubview(circle)
        
        UIView.animate(withDuration: 2.0, animations: { () -> Void in
            // Move "appleImage" from current position to center
            appleImage.center = containerView.center
            // Change current background color to white
            circle.backgroundColor = UIColor.white
        })
        
        print("\nhello anim\n")
//        let label = UILabel()
//        label.frame = CGRect(x: 20, y: 10, width: 400, height: 100)
//        label.text = "Hello World!"
//        label.textColor = .black
//        UIView.animate(withDuration: 5) {
//            label.frame = CGRect(x: 20, y: 10, width: 400, height: 100)
//        }
    }
    
    func makeAlert() {
        let alert = UIAlertController(title: "Error", message: "This login is not existent", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
        activityIndicator.isHidden = true
    }
}
