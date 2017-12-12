//
//  PunchViewController.swift
//  Chrono
//
//  Created by iGuest on 12/7/17.
//  Copyright © 2017 SJSquared. All rights reserved.
//

import UIKit

class PunchViewController: UIViewController {

    @IBOutlet weak var currTime: UILabel!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var clockIn: UIButton!
    @IBOutlet weak var mealOut: UIButton!
    @IBOutlet weak var mealIn: UIButton!
    @IBOutlet weak var clockOut: UIButton!
    var timer = Timer()


    @IBAction func clickClockIn(_ sender: Any) {
        
    }
    
    @IBAction func clickMealOut(_ sender: Any) {
        
    }
    
    @IBAction func clickMealIn(_ sender: Any) {
        
    }
    
    @IBAction func clickClockOut(_ sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0,
            target: self,
            selector: #selector(tick),
            userInfo: nil,
            repeats: true)
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
