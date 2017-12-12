//
//  EmployeeChartViewController.swift
//  Chrono
//
//  Created by Sarah Feldmann on 12/11/17.
//  Copyright © 2017 SJSquared. All rights reserved.
//

import UIKit
import Charts
import Firebase
import FirebaseDatabase

class EmployeeChartViewController: UIViewController {

    var ref: DatabaseReference!
    var userValue : NSDictionary = ["key":"value"]
    var currentCompany : String = ""
    
    var data = AppData.shared
    
    @IBOutlet weak var barChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("data.currentCompany \(data.currentCompany)")
        // Do any additional setup after loading the view.
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
