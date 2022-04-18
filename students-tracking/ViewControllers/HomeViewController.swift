//
//  HomeViewController.swift
//  students-tracking
//
//  Created by Vale Delgado on 12/04/22.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    @IBOutlet weak var signoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let uid = UserDefaults.standard.value(forKey: "uid") as? String
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signout(_ sender: Any) {
        let session = UserDefaults.standard
        session.removeObject(forKey: "uid")
        
        do {
            try Auth.auth().signOut()
            self.showLogin()
        } catch {
            //Error
        }
    }
    
    func showLogin() {
        let login = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.login) as? LoginViewController
        view.window?.rootViewController = login
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func homeUnwindAction(unwindSegue: UIStoryboardSegue){}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
