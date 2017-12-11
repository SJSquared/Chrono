//
//  ViewController.swift
//  Chrono
//
//  Created by Jimmy Nguyen on 11/20/17.
//  Copyright © 2017 SJSquared. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var ref: DatabaseReference!
    
    @IBAction func action(_ sender: UIButton) {
        if emailText.text != "" && passwordText.text != "" {
            if segmentControl.selectedSegmentIndex == 0 && passwordText.text! == confirmPasswordText.text! { //sign-up
                Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (user, error) in
                    if (user != nil) {
                        let values = ["email": self.emailText.text!]
                        
                        guard let uid = user?.uid else {
                            return
                        }
                        
                        let usersReference = self.ref.child("users").child(uid)
                        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                            if err != nil {
                                print(err)
                                return
                            }
                            print("saved user to firebase db")
                        })
                        self.performSegue(withIdentifier: "toOnboard", sender: self)
                    } else {
                        let errorMsg : String!
                        errorMsg = error?.localizedDescription
                        self.errorLabel.text! = errorMsg
                    }
                }
                
            } else { //login user
                Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (user, error) in
                    if (user != nil) {
                        // Reading data once that we do not expect to change
                        self.ref.child("users").child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                            
                            // Saves JSON object of the user
                            let value = snapshot.value as? NSDictionary
                            
                            // Grabs the value of the userType key of the JSON object
                            let userTypeValue = value?["userType"] as? String
                            
                            // The user logging in already did the onboard process
                            if (userTypeValue != nil || userTypeValue != "") {
                                self.performSegue(withIdentifier: "toMain", sender: self)
                            } else { // The logging in user still needs to complete onboard process
                                self.performSegue(withIdentifier: "toOnboard", sender: self)
                            }
                        })
                    }
                }
            }
        }
        
    }
    
    @IBAction func segmentControlAction(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 1 {
            confirmPasswordText.isHidden = true;
            confirmPasswordLabel.text = "";
            signupButton.setTitle("Login", for: .normal)
        } else {
            signupButton.setTitle("Sign-up", for: .normal)
            confirmPasswordLabel.text = "Confirm password";
            confirmPasswordText.isHidden = false;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Firebase reference
        ref = Database.database().reference()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //super.viewWillDisappear(animated)
        //self.navigationController?.navigationBar.isHidden = false
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

