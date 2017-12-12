//
//  AppData.swift
//  Chrono
//
//  Created by Sarah Feldmann on 12/11/17.
//  Copyright © 2017 SJSquared. All rights reserved.
//

import UIKit

class AppData: NSObject {

    static let shared = AppData()
    
    // Employers
    
    var currentCompany: String = ""
    var employeeWork = [String:Any]()
    var employeeDays = [String]()
    var employeeIds = [String]()
    var userType : String = ""
    
    var employeeIdDays = [String:Any]()
//    var currentUser: String
//
//    var employees = [String : Any?]
    
    // Employees
    
    override init(){
        super.init()
    }
    
}

