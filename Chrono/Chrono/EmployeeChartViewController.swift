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
    var currentCompany : String = ""
    
    var data = AppData.shared
    
    @IBOutlet weak var barChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChartUpdate()
        print("data.currentCompany \(data.currentCompany)")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func barChartUpdate(){
        var dataArray = [BarChartDataEntry]()
        var keys = self.data.employeeDays
        for i in 0...self.data.employeeWork.count-1 {
            dataArray.append(BarChartDataEntry(x: Double(i), y: (self.data.employeeWork[keys[i]] as! NSString).doubleValue))
        }
        let dataSet = BarChartDataSet(values:dataArray, label: "Hours Worked")
        let data = BarChartData(dataSets: [dataSet])
        barChartView.data = data
        
//        let entry1 = BarChartDataEntry(x: 1.0, y: Double(number1.value))
//        let entry2 = BarChartDataEntry(x: 2.0, y: Double(number2.value))
//        let entry3 = BarChartDataEntry(x: 3.0, y: Double(number3.value))
//        let dataSet = BarChartDataSet(values: [entry1, entry2, entry3], label: "Widgets Type")
//        let data = BarChartData(dataSets: [dataSet])
//        barChartView.data = data
//        barChartView.chartDescription?.text = "Number of Widgets by Type"
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
