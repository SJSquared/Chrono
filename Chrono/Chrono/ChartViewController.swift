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
 
    
    @IBOutlet weak var barView2: BarChartView!
    @IBOutlet weak var pieChart: PieChartView!
    
//    @IBOutlet var barView2: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        updateChartWithData()
//        pieChartUpdate()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateChartWithData(){
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<8 {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(i))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Hours logged")
        let chartData = BarChartData(dataSet: chartDataSet)
        barView2.data = chartData
    }
    
    func pieChartUpdate () {
        
        // Basic set up of plan chart
        
        let entry1 = PieChartDataEntry(value: Double(4), label: "#1")
        let entry2 = PieChartDataEntry(value: Double(3), label: "#2")
        let entry3 = PieChartDataEntry(value: Double(6), label: "#3")
        let dataSet = PieChartDataSet(values: [entry1, entry2, entry3], label: "Widget Types")
        let data = PieChartData(dataSet: dataSet)
        pieChart.data = data
        pieChart.chartDescription?.text = "Share of Widgets by Type"
        
        // Color
        dataSet.colors = ChartColorTemplates.joyful()
        //dataSet.valueColors = [UIColor.black]
        pieChart.backgroundColor = UIColor.black
        pieChart.holeColor = UIColor.clear
        pieChart.chartDescription?.textColor = UIColor.white
        pieChart.legend.textColor = UIColor.white
        
        // Text
        pieChart.legend.font = UIFont(name: "Futura", size: 10)!
        pieChart.chartDescription?.font = UIFont(name: "Futura", size: 12)!
        pieChart.chartDescription?.xOffset = pieChart.frame.width
        pieChart.chartDescription?.yOffset = pieChart.frame.height * (2/3)
        pieChart.chartDescription?.textAlign = NSTextAlignment.left
        
        // Refresh chart with new data
        pieChart.notifyDataSetChanged()
    }
    
}

