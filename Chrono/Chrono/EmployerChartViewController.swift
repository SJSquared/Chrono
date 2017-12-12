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
//        let userId : String = (Auth.auth().currentUser?.uid)!
//        print("userID \(userId)")
//
//        refHandle = ref.observe(DataEventType.childAdded, with: { (snapshot) in
//            let dataDict = snapshot.value as! [String: AnyObject]
//
//            print(dataDict)
//
//            let companyOwner = dataDict["users"]![userId]!
        
//            print("companyOwner \(companyOwner)")
            
//            let companyName = companyOwner!["currentCompany"]
//
//            print(companyName)
//
//            let employees : [AnyObject] = dataDict["companies"][companyName]
//
//            print(employees)
//        })
        
        
        
        
        
        
        
        
        // Listens for the current logged in user
//        let handle = Auth.auth().addStateDidChangeListener { (auth, user) in
//            self.ref.child("users").child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
//                self.userValue = snapshot.value as! NSDictionary
//                self.currentCompany = self.userValue["currentCompany"] as! String
//                self.ref.child("companies").child(self.currentCompany).observeSingleEvent(of: .value, with: { (snapshot) in
//                    let value = snapshot.value as! NSDictionary
//
//                    // Saves all the employee IDS in the current company
//                    self.employeeIDs = value.allKeys as! [String]
//
//                })
//            })
//        }
//
       
        
        
//        print(dataDict["users"])
        
//        var json: [Any]?
//        do {
//            json = try JSONSerialization.jsonObject(with: dataDict)
//        } catch {
//            print(error)
//        }
//        print("json \(json)")
        

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
        var employeeIds = self.data.employeeIds
        
        for i in 0...employeeIds.count-1{
            
        }
        
        
        
//        let groupSpace = 0.08
//        let barSpace = 0.03
//        let barWidth = 0.2
//        // (0.2 + 0.03) * 4 + 0.08 = 1.00 -> interval per "group"
//        let randomMultiplier = 100 * 100000
//        let groupCount = 10 + 1
//        let startYear = 1980
//        let endYear = startYear + groupCount
//
//        let block: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
//            return BarChartDataEntry(x: Double(i), y: Double(arc4random_uniform(UInt32(randomMultiplier))))
//        }
//        let yVals1 = (startYear ..< endYear).map(block)
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
    }
}

