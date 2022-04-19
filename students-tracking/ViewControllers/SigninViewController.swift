//
//  SigninViewController.swift
//  students-tracking
//
//  Created by Vale Delgado on 16/04/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SigninViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    private lazy var dbRef : DatabaseReference = Database.database().reference().child("users/")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signin(_ sender: Any) {
        let email = emailField.text
        let password = passwordField.text
        
        if (email != nil && password != nil && nameField.text != nil && idField.text != nil) {
            let newUser = UserModel(name: nameField.text!, id: idField.text!)
            
            Auth.auth().createUser(withEmail: email!, password: password!) {
                result, error in
                if let result = result, error == nil {
                    let uid = result.user.uid
                    
                    self.dbRef.child(uid).setValue(newUser.getFirebaseStructure())
                    
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
    
    @IBAction func showLogin(_ sender: Any) {
        let login = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.login) as? LoginViewController
        view.window?.rootViewController = login
        view.window?.makeKeyAndVisible()
    }
}
