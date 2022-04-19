//
//  HomeViewController.swift
//  students-tracking
//
//  Created by Vale Delgado on 12/04/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    @IBOutlet weak var homeItem: UITabBarItem!
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var signoutBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var dbRef : DatabaseReference = Database.database().reference().child("records/")
    var records: [RecordModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tabBar.delegate = self
        self.tabBar.selectedItem = homeItem
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
    
    @IBAction func showProfile(_ sender: Any) {
        let profile = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.profile) as? ProfileViewController
        view.window?.rootViewController = profile
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
