//
//  EmployeesViewController.swift
//  Chrono
//
//  Created by iGuest on 12/11/17.
//  Copyright © 2017 SJSquared. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class EmployeesViewController: UIViewController {
    var ref: DatabaseReference!
    
    var currentCompany : String = ""
    var userValue : NSDictionary = ["key":"value"]
    var companyValue: NSDictionary = ["key":"value"]
    var employeeIDs = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        // Listens for the current logged in user
        let handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            self.ref.child("users").child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                self.userValue = snapshot.value as! NSDictionary
                self.currentCompany = self.userValue["currentCompany"] as! String
                self.ref.child("companies").child(self.currentCompany).observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as! NSDictionary
                    
                    // Saves all the employee IDS in the current company
                    self.employeeIDs = value.allKeys as! [String]
                })
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

