//
//  EmployeesTableViewController.swift
//  Chrono
//
//  Created by iGuest on 12/12/17.
//  Copyright © 2017 SJSquared. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class EmployeesTableViewController: UITableViewController {

   
    @IBOutlet var tableview: UITableView!
    var uid: String!
    var ref: DatabaseReference!
    var company: String!
//    var emp : [String] = []
//    var emails : [String] = []
    var emp : [String] = ["Jenny Yang", "Sarah Feldmann", "Jimmy Nguyen"]
    var emails : [String] = ["jj@jj.com", "s@s.com", "jbn@j.com"]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
        self.uid = Auth.auth().currentUser?.uid
        
        _ = self.ref.observe(DataEventType.value, with: { (snapshot) in
            
            let allValue = snapshot.value as? [String : NSDictionary] ?? [:]
            let allComp = allValue["companies"] as? [String : NSDictionary] ?? [:]
            let allUsers = allValue["users"] as? [String : NSDictionary] ?? [:]
            let currUser = allUsers[self.uid] as? [String : String] ?? [:]
            print("HIIIII " + currUser["currentCompany"]!)
            self.company = currUser["currentCompany"]
            
            let thisComp = allComp[self.company] as? [String : NSDictionary] ?? [:]
            
            let allE = Array(thisComp.keys) // list of uid
            self.emp = allE.filter { $0 == "email" }
            
            for e in allE {
                let single = allUsers[e] as? [String : String] ?? [:]

                self.emails.append(single["email"]!)
                self.emp.append(single["firstName"]! + " " +  single["lastName"]!)
            }
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.emp.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(self.emp)
        print(self.emails)

        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "eCell")
        cell.textLabel!.text = self.emp[indexPath.row]
        cell.detailTextLabel?.text = self.emails[indexPath.row]
        return cell
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
