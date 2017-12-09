//
//  ChartViewController.swift
//  Chrono
//
//  Created by Sarah Feldmann on 12/7/17.
//  Copyright © 2017 SJSquared. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {
 
    
    @IBOutlet weak var barView: BarChartView!
//    @IBOutlet weak var lineView: LineChartView!
    
    
    func updateChartWithData(){
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<8 {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(i))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Hours logged")
        let chartData = BarChartData(dataSet: chartDataSet)
        barView.data = chartData
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateChartWithData()
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

