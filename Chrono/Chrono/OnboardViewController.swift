//
//  OnboardViewController.swift
//  Chrono
//
//  Created by Jimmy Nguyen on 11/25/17.
//  Copyright © 2017 SJSquared. All rights reserved.
//

import UIKit
import FirebaseDatabase

class OnboardViewController: UIViewController {
    var ref: DatabaseReference?
    
    override func viewDidLoad() {
        ref = Database.database().reference()
    }
}
