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

    @IBOutlet weak var currTime: UILabel!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var clockIn: UIButton!
    @IBOutlet weak var mealOut: UIButton!
    @IBOutlet weak var mealIn: UIButton!
    @IBOutlet weak var clockOut: UIButton!
    var timer = Timer()
    var uid: String!
    var ref: DatabaseReference!
    var company: String!
    
    @IBAction func clickClockIn(_ sender: Any) {
        let currTime = Date()
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
        self.ref.child("companies").child(self.company).child(self.uid).child(date + "/" + type).setValue(DateFormatter.localizedString(from: time,
                                                                                            dateStyle: .medium,
                                                                                                            timeStyle: .medium))

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        timer = Timer.scheduledTimer(timeInterval: 1.0,
            target: self,
            selector: #selector(tick),
            userInfo: nil,
            repeats: true)
        uid = Auth.auth().currentUser?.uid
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.company = value?["currentCompany"] as? String ?? ""
            }) { (error) in
            print(error.localizedDescription)
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
