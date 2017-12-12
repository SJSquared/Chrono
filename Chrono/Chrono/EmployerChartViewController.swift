//
//  barView2Controller.swift
//  Chrono
//
//  Created by Sarah Feldmann on 12/7/17.
//  Copyright © 2017 SJSquared. All rights reserved.
//

import UIKit
import Charts
import Firebase

class EmployerChartViewController: UIViewController {
    @IBOutlet weak var barView: BarChartView!
    
    var ref: DatabaseReference!
    var refHandle: UInt!
    
    
//    @IBOutlet weak var barView: BarChartView!
//    @IBOutlet weak var pieChart: PieView2!
    
//    @IBOutlet var barView: BarbarView2!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        refHandle = ref.observe(DataEventType.value, with: { (snapshot) in
            let dataDict = snapshot.value as! [String: AnyObject]
            
            print(dataDict)
        })
        
        let userId : String = (Auth.auth().currentUser?.uid)!
        print("userID \(userId)")
//        ref.child("Users").child(userId).observeSingleEventofType(.Value), withBlock: { (snapshot) in
//            let email = snapshot.value!["Email"] as String!
//
//        }
//
        self.title = "Multiple Bar Chart"
   
        
        barView.chartDescription?.enabled =  false
        
        barView.pinchZoomEnabled = false
        barView.drawBarShadowEnabled = false
        
        let l = barView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.drawInside = true
        l.font = .systemFont(ofSize: 8, weight: .light)
        l.yOffset = 10
        l.xOffset = 10
        l.yEntrySpace = 0
        
        updateChartWithData()
        
        let xAxis = barView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.granularity = 1
        xAxis.centerAxisLabelsEnabled = true
//        xAxis.valueFormatter = IntAxisValueFormatter()
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.maximumFractionDigits = 1
        
        let leftAxis = barView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
//        leftAxis.valueFormatter = LargeValueFormatter()
        leftAxis.spaceTop = 0.35
        leftAxis.axisMinimum = 0

        
//        pieChartUpdate()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateChartWithData(){
//        var dataEntries: [BarChartDataEntry] = []
//        for i in 0..<8 {
//            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(i))
//            dataEntries.append(dataEntry)
//        }
//        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Hours logged")
//        let chartData = BarChartData(dataSet: chartDataSet)
//        barView.data = chartData
        
        let groupSpace = 0.08
        let barSpace = 0.03
        let barWidth = 0.2
        // (0.2 + 0.03) * 4 + 0.08 = 1.00 -> interval per "group"
        let randomMultiplier = 100 * 100000
        let groupCount = 10 + 1
        let startYear = 1980
        let endYear = startYear + groupCount
        
        let block: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(i), y: Double(arc4random_uniform(UInt32(randomMultiplier))))
        }
        let yVals1 = (startYear ..< endYear).map(block)
        let yVals2 = (startYear ..< endYear).map(block)
        let yVals3 = (startYear ..< endYear).map(block)
        let yVals4 = (startYear ..< endYear).map(block)
        
        let set1 = BarChartDataSet(values: yVals1, label: "Company A")
        set1.setColor(UIColor(red: 104/255, green: 241/255, blue: 175/255, alpha: 1))
        
        let set2 = BarChartDataSet(values: yVals2, label: "Company B")
        set2.setColor(UIColor(red: 164/255, green: 228/255, blue: 251/255, alpha: 1))
        
        let set3 = BarChartDataSet(values: yVals3, label: "Company C")
        set3.setColor(UIColor(red: 242/255, green: 247/255, blue: 158/255, alpha: 1))
        
        let set4 = BarChartDataSet(values: yVals4, label: "Company D")
        set4.setColor(UIColor(red: 255/255, green: 102/255, blue: 0/255, alpha: 1))
        
        let data = BarChartData(dataSets: [set1, set2, set3, set4])
        data.setValueFont(.systemFont(ofSize: 10, weight: .light))
//        data.setValueFormatter(LargeValueFormatter())
        
        // specify the width each bar should have
        data.barWidth = barWidth
        
        // restrict the x-axis range
        barView.xAxis.axisMinimum = Double(startYear)
        
        // groupWidthWithGroupSpace(...) is a helper that calculates the width each group needs based on the provided parameters
        barView.xAxis.axisMaximum = Double(startYear) + data.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(groupCount)
        
        data.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
        
        barView.data = data
    }
    
//    func pieChartUpdate () {
//
//        // Basic set up of plan chart
//
//        let entry1 = PieChartDataEntry(value: Double(4), label: "#1")
//        let entry2 = PieChartDataEntry(value: Double(3), label: "#2")
//        let entry3 = PieChartDataEntry(value: Double(6), label: "#3")
//        let dataSet = PieChartDataSet(values: [entry1, entry2, entry3], label: "Widget Types")
//        let data = PieChartData(dataSet: dataSet)
//        pieChart.data = data
//        pieChart.chartDescription?.text = "Share of Widgets by Type"
//
//        // Color
//        dataSet.colors = ChartColorTemplates.joyful()
//        //dataSet.valueColors = [UIColor.black]
//        pieChart.backgroundColor = UIColor.black
//        pieChart.holeColor = UIColor.clear
//        pieChart.chartDescription?.textColor = UIColor.white
//        pieChart.legend.textColor = UIColor.white
//
//        // Text
//        pieChart.legend.font = UIFont(name: "Futura", size: 10)!
//        pieChart.chartDescription?.font = UIFont(name: "Futura", size: 12)!
//        pieChart.chartDescription?.xOffset = pieChart.frame.width
//        pieChart.chartDescription?.yOffset = pieChart.frame.height * (2/3)
//        pieChart.chartDescription?.textAlign = NSTextAlignment.left
//
//        // Refresh chart with new data
//        pieChart.notifyDataSetChanged()
//    }
    
}

