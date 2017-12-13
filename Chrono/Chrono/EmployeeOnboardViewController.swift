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

class EmployeeOnboardViewController: UIViewController {
    var ref: DatabaseReference!
    let user = Auth.auth().currentUser
    
    @IBOutlet weak var companyName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBAction func confirmTap(_ sender: UIButton) {
        let userValues = ["firstName": self.firstName.text!, "lastName": self.lastName.text!, "email": user!.email, "currentCompany": companyName.text!, "userType": "employee"]
        
        guard let uid = user?.uid else {
            return
        }
        
        let usersReference = self.ref.child("users").child(user!.uid)
        usersReference.updateChildValues(userValues, withCompletionBlock: { (err, ref) in
            if err != nil {
                print(err)
                return
            }
            print("update user to firebase db")
        })
        
        let userCompanyValue = ["email": user!.email]
        let companyReference = self.ref.child("companies").child(companyName.text!).child(user!.uid)
        companyReference.updateChildValues(userCompanyValue, withCompletionBlock: { (err, ref) in
            if err != nil {
                print(err)
                return
            }
            print("update user to firebase db")
        })
    }
    
    override func viewDidLoad() {
        ref = Database.database().reference()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



