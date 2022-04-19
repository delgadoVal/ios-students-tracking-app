//
//  ProfileViewController.swift
//  students-tracking
//
//  Created by Vale Delgado on 18/04/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProfileViewController: UIViewController, UITabBarDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileItem: UITabBarItem!
    @IBOutlet weak var tabBar: UITabBar!
    
    private lazy var dbRef : DatabaseReference = Database.database().reference().child("users/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.delegate = self
        self.tabBar.selectedItem = profileItem
        
        let uid = Auth.auth().currentUser?.uid
        dbRef.child(uid!).observeSingleEvent(of: .value, with: { snapshot in
            self.nameLabel.text = snapshot.childSnapshot(forPath: "name").value as? String
        })
        
        // Do any additional setup after loading the view.
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if(item.tag == 1) {
            let home = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.home) as? HomeViewController
            view.window?.rootViewController = home
            view.window?.makeKeyAndVisible()
        } else if(item.tag == 2) {
            let profile = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.profile) as? ProfileViewController
            view.window?.rootViewController = profile
            view.window?.makeKeyAndVisible()
        }
    }
    
    @IBAction func logout(_ sender: Any) {
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
