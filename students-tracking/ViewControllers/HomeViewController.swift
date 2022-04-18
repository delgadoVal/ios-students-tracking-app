//
//  HomeViewController.swift
//  students-tracking
//
//  Created by Vale Delgado on 12/04/22.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var signoutBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as! RecordTableViewCell;
        
        cell.dayLabel.text = "registro"
        cell.hoursLabel.text = "horas"

        // Configure the cell...

        return cell
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
