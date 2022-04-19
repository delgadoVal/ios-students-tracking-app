//
//  CreateViewController.swift
//  students-tracking
//
//  Created by Vale Delgado on 17/04/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateViewController: UIViewController {

    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var doneBtn: UIBarButtonItem!
    @IBOutlet weak var checkinDate: UIDatePicker!
    @IBOutlet weak var checkoutDate: UIDatePicker!
    
    private lazy var dbRef : DatabaseReference = Database.database().reference().child("records/")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addRecord(_ sender: Any) {
        let checkin = checkinDate.date
        let checkout = checkoutDate.date
        let seconds = checkout.timeIntervalSinceReferenceDate - checkin.timeIntervalSinceReferenceDate
        let minutes = Int(trunc(seconds / 60.0)) as Int
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss Z"
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        let checkinFormatted = formatter.string(from: checkin)
        let checkoutFormatted = formatter.string(from: checkout)
        
        formatter.dateFormat = "EEEE dd MMMM, yyyy"
        let day = formatter.string(from: checkin)
        
        let newRecord = RecordModel(day: day, minutes: minutes, checkin: checkinFormatted, checkout: checkoutFormatted)
        
        let uid = Auth.auth().currentUser?.uid
        self.dbRef.child(uid!).childByAutoId().setValue(newRecord.getFirebaseStructure())
        
        performSegue(withIdentifier: "unwindToHome", sender: self)
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
