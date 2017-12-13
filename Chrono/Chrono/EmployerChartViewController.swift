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
        self.title = "Employee Hours Summary"
   
        
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
        
//        for i in 0...employeeData.count-1{
//            print(employeeData[i])
//            var subKeys = employeeData[i].keys
//            var piece = employeeData[i]
//            print(piece[subKeys[i]])
//        }
        
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries1: [BarChartDataEntry] = []
        

        
        let chartDataSet = BarChartDataSet(values: [BarChartDataEntry(x: 1, y: 8.5), BarChartDataEntry(x: 2, y: 9.5), BarChartDataEntry(x: 2, y: 7.5)], label: "Employee 1")
        let chartDataSet1 = BarChartDataSet(values: [BarChartDataEntry(x: 1, y: 5.5), BarChartDataEntry(x: 2, y: 6.5), BarChartDataEntry(x: 2, y: 9.5)], label: "Employee 2")
        let chartDataSet2 = BarChartDataSet(values: [BarChartDataEntry(x: 1, y: 6.5), BarChartDataEntry(x: 2, y: 6.9), BarChartDataEntry(x: 2, y: 8.0)], label: "Employee 3")
        
        
        
        let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet1,chartDataSet2]
        let chartData = BarChartData(dataSets: dataSets)

        chartDataSet.colors = [UIColor(red: 0/255, green: 110/255, blue: 137/255, alpha: 1)]

        let groupSpace = 0.3
        let barSpace = 0.05
        let barWidth = 0.3

        let groupCount = 3
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

}

}
