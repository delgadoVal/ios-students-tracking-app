//
//  LoginViewController.swift
//  students-tracking
//
//  Created by Vale Delgado on 12/04/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func login(_ sender: Any) {
        let email = emailField.text
        let password = passwordField.text
        
        if (email != nil && password != nil) {
            Auth.auth().signIn(withEmail: email!, password: password!) {
                result, error in
                if let result = result, error == nil {
                    let uid = result.user.uid
                    let session = UserDefaults.standard
                    session.set(uid, forKey: "uid")
                    session.synchronize()
                    self.showHome()
                }
            }
        } else {
            
        }
    }
    
    func showHome() {
        let home = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.home) as? HomeViewController
        view.window?.rootViewController = home
        view.window?.makeKeyAndVisible()
    }
}
