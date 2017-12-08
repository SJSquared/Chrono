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
                        self.performSegue(withIdentifier: "toOnboard", sender: self)
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
            confirmPasswordLabel.text = "confirm password";
            confirmPasswordText.isHidden = false;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        //self.navigationController?.navigationBar.isHidden = true
        
       /* let blueColor = UIColor(red: 154, green: 209, blue: 212, alpha: 1)
        let greenColor = UIColor(red: 98, green: 95, blue: 112, alpha: 1)
        
        let gradientColor: [CGColor] = [blueColor.cgColor, greenColor.cgColor]
        let gradientLocations: [NSNumber] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColor
        gradientLayer.locations = gradientLocations
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)*/
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

