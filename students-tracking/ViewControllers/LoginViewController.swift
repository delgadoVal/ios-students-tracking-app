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
    @IBOutlet weak var signinBtn: UIButton!
    weak var handle: AuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            if ((user) != nil) {
                self?.showHome()
            }
        }
    }

    @IBAction func login(_ sender: Any) {
        let email = emailField.text
        let password = passwordField.text
        
        if (email != nil && password != nil) {
            Auth.auth().signIn(withEmail: email!, password: password!) {
                result, error in
                if result != nil, error == nil {
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
    
    @IBAction func showSignin(_ sender: Any) {
        let signin = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.signin) as? SigninViewController
        view.window?.rootViewController = signin
        view.window?.makeKeyAndVisible()
    }
}
