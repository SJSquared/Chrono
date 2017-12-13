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
import FirebaseDatabase

class EmployerChartViewController: UIViewController {
    @IBOutlet weak var barView: BarChartView!
    
    var refHandle: UInt!
    
    var currentCompany : String = ""
    var userValue : NSDictionary = ["key":"value"]
    var companyValue: NSDictionary = ["key":"value"]
    var employeeIDs = [String]()
    var data = AppData.shared
    
    
//    @IBOutlet weak var barView: BarChartView!
//    @IBOutlet weak var pieChart: PieView2!
    
//    @IBOutlet var barView: BarbarView2!
    
    var ref: DatabaseReference!
    var companyData = [String]()
    var databaseHandle : DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
       databaseHandle = ref.child("companies").observe(.childAdded, with: {(snapshot) in
        let company = snapshot.value as? String
        if let actualCompany = company {
            self.companyData.append(actualCompany)
        }
        })
        
        print("companyData \(companyData)")
        

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
        var employeeIds = self.data.employeeIds
//        print("employeeIds \(self.data.employeeIds)")
        
        print("employeeData in employerChart")
        
        
        var employeeData = self.data.employeeData
        print(employeeData)
        
        for i in 0...employeeData.count-1{
            print(employeeData[i])
            print(employeeData[i])
        }
        
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries1: [BarChartDataEntry] = []
        

        
        let chartDataSet = BarChartDataSet(values: [BarChartDataEntry(x: 1, y: 8.5), BarChartDataEntry(x: 2, y: 9.5), BarChartDataEntry(x: 2, y: 7.5)], label: "Employee 1")
        let chartDataSet1 = BarChartDataSet(values: [BarChartDataEntry(x: 1, y: 5.5), BarChartDataEntry(x: 2, y: 6.5), BarChartDataEntry(x: 2, y: 9.5)], label: "Employee 2")
        
        let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet1]
        let chartData = BarChartData(dataSets: dataSets)

        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]


        let groupSpace = 0.3
        let barSpace = 0.05
        let barWidth = 0.3

        let groupCount = 12
        let startYear = 0


        chartData.barWidth = barWidth;
        barView.xAxis.axisMinimum = Double(startYear)
        let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        print("Groupspace: \(gg)")
        barView.xAxis.axisMaximum = Double(startYear) + gg * Double(groupCount)
        
        chartData.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
        chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        barView.notifyDataSetChanged()

        
        barView.data = chartData

//        let yVals1 = (0 ..< 12).map(block)
//        let yVals2 = (startYear ..< endYear).map(block)
//        let yVals3 = (startYear ..< endYear).map(block)
//        let yVals4 = (startYear ..< endYear).map(block)
//
//        let set1 = BarChartDataSet(values: yVals1, label: "Company A")
//        set1.setColor(UIColor(red: 104/255, green: 241/255, blue: 175/255, alpha: 1))
//
//        let set2 = BarChartDataSet(values: yVals2, label: "Company B")
//        set2.setColor(UIColor(red: 164/255, green: 228/255, blue: 251/255, alpha: 1))
//
//        let set3 = BarChartDataSet(values: yVals3, label: "Company C")
//        set3.setColor(UIColor(red: 242/255, green: 247/255, blue: 158/255, alpha: 1))
//
//        let set4 = BarChartDataSet(values: yVals4, label: "Company D")
//        set4.setColor(UIColor(red: 255/255, green: 102/255, blue: 0/255, alpha: 1))
//
//        let data = BarChartData(dataSets: [set1, set2, set3, set4])
//        data.setValueFont(.systemFont(ofSize: 10, weight: .light))
////        data.setValueFormatter(LargeValueFormatter())
//
//        // specify the width each bar should have
//        data.barWidth = barWidth
//
//        // restrict the x-axis range
//        barView.xAxis.axisMinimum = Double(startYear)
//
//        // groupWidthWithGroupSpace(...) is a helper that calculates the width each group needs based on the provided parameters
//        barView.xAxis.axisMaximum = Double(startYear) + data.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(groupCount)
//
//        data.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
//
//        barView.data = data
//    }
}

}
