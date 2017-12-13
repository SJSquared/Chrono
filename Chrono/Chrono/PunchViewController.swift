//
//  PunchViewController.swift
//  Chrono
//
//  Created by iGuest on 12/7/17.
//  Copyright © 2017 SJSquared. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PunchViewController: UIViewController {
   

    @IBOutlet weak var inTime: UILabel!
    @IBOutlet weak var mOutTime: UILabel!
    @IBOutlet weak var mInTime: UILabel!
    @IBOutlet weak var outTime: UILabel!
    @IBOutlet weak var currTime: UILabel!
    @IBOutlet weak var clockIn: UIButton!
    @IBOutlet weak var mealOut: UIButton!
    @IBOutlet weak var mealIn: UIButton!
    @IBOutlet weak var clockOut: UIButton!
    var timer = Timer()
    var uid: String!
    var clockInTime : Date!
    var ref: DatabaseReference!
    var company: String!
    var date : String!
   
    
    @IBAction func clickClockIn(_ sender: Any) {
        let currTime = Date()
        self.clockInTime = currTime
        writeData("cIn", currTime)
    }
    
    @IBAction func clickMealOut(_ sender: Any) {
        let currTime = Date()
        writeData("mOut", currTime)
    }
    
    @IBAction func clickMealIn(_ sender: Any) {
        let currTime = Date()
        writeData("mIn", currTime)
    }
    
    @IBAction func clickClockOut(_ sender: Any) {
        let currTime = Date()
        writeData("cOut", currTime)
        
    }
    
    func writeData(_ type: String, _ time: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        print(dateFormatter.string(from: time))
        date = dateFormatter.string(from: time)
        self.ref.child("companies").child(self.company).child(self.uid).child(self.date + "/" + type).setValue(DateFormatter.localizedString(from: time, dateStyle: .none, timeStyle: .medium))
        if (type == "cOut") {
            self.ref.child("companies").child(self.company).child(self.uid).child(date + "/interval").setValue(time.timeIntervalSince(self.clockInTime))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        self.date = dateFormatter.string(from: Date())
        
        self.ref = Database.database().reference()
        clockInTime = Date()
        timer = Timer.scheduledTimer(timeInterval: 1.0,
            target: self,
            selector: #selector(tick),
            userInfo: nil,
            repeats: true)
        self.uid = Auth.auth().currentUser?.uid
        let usersReference = self.ref.child("users").child(self.uid)
        let r2 = self.ref.child("companies")
        
        var refHandle = self.ref.observe(DataEventType.value, with: { (snapshot) in
            
            let allValue = snapshot.value as? [String : NSDictionary] ?? [:]
            let allComp = allValue["companies"] as? [String : NSDictionary] ?? [:]
            let allUsers = allValue["users"] as? [String : NSDictionary] ?? [:]
            let currUser = allUsers[self.uid] as? [String : String] ?? [:]
            print("HIIIII " + currUser["currentCompany"]!)
            self.company = currUser["currentCompany"]

            let thisComp = allComp[self.company] as? [String : NSDictionary] ?? [:]
            let thisUser = thisComp[self.uid] as? [String : Any] ?? [:]
            let today = thisUser[self.date] as? [String : Any] ?? [:]
            
            self.inTime.text = "Clocked In: " + (today["cIn"] != nil ? (today["cIn"] as! String): "")
            self.mOutTime.text = "Meal Out: " + (today["mOut"] != nil ? (today["mOut"] as! String): "")
            self.mInTime.text = "Meal In: " + (today["mIn"] != nil ? (today["mIn"] as! String): "")
            self.outTime.text = "Clocked Out: " + (today["cOut"] != nil ? (today["cOut"] as! String): "")

        })
    }

    @objc func tick() {
        currTime.text = DateFormatter.localizedString(from: Date(),
                                                            dateStyle: .medium,
                                                            timeStyle: .medium)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
