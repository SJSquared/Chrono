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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        let handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            var currentCompany : String = ""
            self.ref.child("users").child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                let userValue = snapshot.value as? NSDictionary
                currentCompany = userValue?["currentCompany"] as! String
                print(userValue)
                print(currentCompany)
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

