//
//  ViewController.swift
//  Chrono
//
//  Created by Jimmy Nguyen on 11/20/17.
//  Copyright © 2017 SJSquared. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBAction func action(_ sender: UIButton) {
        if emailText.text != "" && passwordText.text != "" {
            if segmentControl.selectedSegmentIndex == 0 && passwordText.text! == confirmPasswordText.text! { //sign-up
                Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (user, error) in
                    if (user != nil) {
                        self.performSegue(withIdentifier: "toOnboard", sender: self)
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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

