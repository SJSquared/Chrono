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
    var userType : String = ""
    
   
    
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

        print("in punchViewController viewDidLoad")
        
        let handle = Auth.auth().addStateDidChangeListener{ (auth, user) in
            self.ref.child("users").child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                self.userValue = snapshot.value as! NSDictionary
                
                // Current Company
                self.data.currentCompany = self.userValue["currentCompany"] as! String
                print("currentCompany \(self.data.currentCompany)")
                
                // User Type
                self.userType = self.userValue["userType"] as! String
                self.data.userType = self.userType
                print("userType 1 \(self.userType)")
                print("self.data.userType \(self.data.userType)")
                
                // Employee Hours
                self.ref.child("companies").child(self.data.currentCompany).child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as! NSDictionary
                    
                    // Grabs the dates and email
                    var keys = value.allKeys as! [String]
                    print("keys \(keys)")
                    
                    // Remove email from keys
                    keys = keys.filter{$0 != "email"}
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
                                    // convert seconds to hours
                                    times.append(date[dateKeys[j]]! as! Double / 3600.0)
                                     print("times \(times)")
                                }
                            }
                            hours[keys[i]] = String(describing: times[i])
                            print(hours)
                            self.data.employeeWork = hours
                            self.data.employeeDays = keys

                            print("enteringIf userTyper employer")
                            print("self.userType \(self.userType)")
                            if(self.data.userType == "employer"){
                                print("entering getEmployeeData")
                                getEmployeeData()

                            }
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
        
        func getEmployeeData(){
            let handle = Auth.auth().addStateDidChangeListener { (auth, user) in
                self.ref.child("companies").child(self.data.currentCompany).observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as! NSDictionary
                    // Saves all the employee IDS in the current company
                    self.data.employeeIds = value.allKeys as! [String]
                    
                    for i in 0...self.data.employeeIds.count-1 {
                        var idIntervalPair = [String:[String:Double]]()
                        var pairsArray = [String:Double]()
                        print("inside i loop")
                        var workDays = value[self.data.employeeIds[i]] as! NSDictionary
                        var interval : Double
                        
                        print("****workDays*****")
                        print(workDays)
                        print(self.data.employeeIds[i])
                        var workDayKeys = workDays.allKeys as! [String]
                        workDayKeys = workDayKeys.filter{$0 != "email"}
                        print("****workDayKeys*****")
                        print(workDayKeys)
                        
                        for j in 0...workDayKeys.count - 1 {
                            print("inside j loop")
                            var timeStamp = workDays[workDayKeys[j]] as! NSDictionary
                            print("****timeStamp*****")
                            print(timeStamp)
                            interval = timeStamp["interval"] as! Double
                            print("****Interval*****")
                            print(interval)
                            
                            var dayIntervalPair : [String: Double]
                            dayIntervalPair = [workDayKeys[j] as! String : interval]
                            print("*********dayIntervalPair********")
                            print(dayIntervalPair)
                            pairsArray[workDayKeys[j] as! String] = interval
                        }
                        idIntervalPair[self.data.employeeIds[i]] = pairsArray
                        print("idIntervalPair")
                        print(idIntervalPair)
                    }
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
