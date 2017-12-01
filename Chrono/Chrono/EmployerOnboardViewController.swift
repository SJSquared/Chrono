//
//  OnboardViewController.swift
//  Chrono
//
//  Created by Jimmy Nguyen on 11/25/17.
//  Copyright © 2017 SJSquared. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class EmployerOnboardViewController: UIViewController {
    var ref: DatabaseReference!
    let user = Auth.auth().currentUser
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var companyName: UITextField!
    
    @IBAction func confirmTap(_ sender: UIButton) {
        let values = ["firstName": self.firstName.text!, "lastName": self.lastName.text!, "companyName": self.companyName.text!, "userType": "employer"]
        
        guard let uid = user?.uid else {
            return
        }
        
        let usersReference = self.ref.child("users").child(uid)
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            if err != nil {
                print(err)
                return
            }
            print("update user to firebase db")
        })
    }
    
    override func viewDidLoad() {
        ref = Database.database().reference()
        print(user!.uid)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

