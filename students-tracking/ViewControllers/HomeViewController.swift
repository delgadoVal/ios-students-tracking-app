//
//  HomeViewController.swift
//  students-tracking
//
//  Created by Vale Delgado on 12/04/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var signoutBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var dbRef : DatabaseReference = Database.database().reference().child("records/")
    var records: [RecordModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getRecords()
    }
    
    func getRecords() {
        self.records = []
        
        let userID = Auth.auth().currentUser?.uid
        dbRef.child(userID!).observeSingleEvent(of: .value, with: { snapshot in
            let allChildren = snapshot.children.allObjects as! [DataSnapshot]
            for child in allChildren {
                let record = RecordModel(
                    day: child.childSnapshot(forPath: "day").value as! String,
                    minutes: child.childSnapshot(forPath: "minutes").value as! Int,
                    checkin: child.childSnapshot(forPath: "checkin").value as! String,
                    checkout: child.childSnapshot(forPath: "checkout").value as! String
                )
                self.records.append(record)
            }
            self.tableView.reloadData()
        })
    }
    
    @IBAction func signout(_ sender: Any) {
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
    
    @IBAction func homeUnwindAction(unwindSegue: UIStoryboardSegue){
        self.getRecords()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.records.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let record = self.records[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as! RecordTableViewCell;
        
        cell.dayLabel.text = "Día: " + record.day
        cell.hoursLabel.text = "Horas: " + String(format: "%.2f", Double(record.minutes) / 60)

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
