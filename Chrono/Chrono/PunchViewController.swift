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
   

    var data = AppData.shared
    
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
    var userValue : NSDictionary = ["key":"value"]
    var currentCompany : String = ""
    var userType : ""
    
   
    
    @IBAction func clickClockIn(_ sender: Any) {
        print("clicky clack")
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
        let date = dateFormatter.string(from: time)
        self.ref.child("companies").child(self.company).child(self.uid).child(date + "/" + type).setValue(DateFormatter.localizedString(from: time, dateStyle: .medium, timeStyle: .medium))
        if (type == "cOut") {
            self.ref.child("companies").child(self.company).child(self.uid).child(date + "/interval").setValue(time.timeIntervalSince(self.clockInTime))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()

        
        let handle = Auth.auth().addStateDidChangeListener{ (auth, user) in
            self.ref.child("users").child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                self.userValue = snapshot.value as! NSDictionary
                
                // Current Company
                self.data.currentCompany = self.userValue["currentCompany"] as! String
                
                // User Type
                var userType = self.userValue["userType"] as! String
                
                // Employee Hours
                self.ref.child("companies").child(self.data.currentCompany).child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as! NSDictionary
                    var keys = value.allKeys as! [String]
                    print("keys \(keys)")
                    keys.remove(at: (keys.count - 1))
                    print("keys after deleting? \(keys)")
                    
                    var times = [Any]()
                    
                    var hours = [String:Any]()
                    if keys.count > 0 {
                        print("in if statement")
                        for i in 0...keys.count-1 {
                            let date = value[keys[i]] as! NSDictionary
                            var dateKeys : [String] = date.allKeys as! [String]
                            for j in 0...dateKeys.count-1 {
                                if(dateKeys[j] == "interval"){
                                    times.append(date[dateKeys[j]]!)
                                }
                            }
                            hours[keys[i]] = String(describing: times[i])
                            print(hours)
                            self.data.employeeWork = hours
                            self.data.employeeDays = keys
                        }
                    }
                })
            })
        }
        
        clockInTime = Date()
        timer = Timer.scheduledTimer(timeInterval: 1.0,
            target: self,
            selector: #selector(tick),
            userInfo: nil,
            repeats: true)
        uid = Auth.auth().currentUser?.uid
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.company = value?["currentCompany"] as? String ?? ""
            }) { (error) in
            print(error.localizedDescription)
        }
        
        
        if userType == "employer" {
            let handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            self.ref.child("companies").child(self.currentCompany).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as! NSDictionary
                // Saves all the employee IDS in the current company
                self.data.employeeIds = value.allKeys as! [String]
                })
            }
        }
        
        
        
        
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
