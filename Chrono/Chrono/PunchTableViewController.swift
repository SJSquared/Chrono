//
//  PunchTableViewController.swift
//  Chrono
//
//  Created by iGuest on 12/12/17.
//  Copyright © 2017 SJSquared. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PunchTableViewController: UITableViewController {

    
    @IBOutlet var tableview: UITableView!
    var uid: String!
    var clockInTime : Date!
    var ref: DatabaseReference!
    var company: String!
    var date : String!
    var dates : [String] = []
    var times : [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        self.date = dateFormatter.string(from: Date())
        
        self.ref = Database.database().reference()
        self.uid = Auth.auth().currentUser?.uid
        let usersReference = self.ref.child("users").child(self.uid)
        let r2 = self.ref.child("companies")
        
        var refHandle = self.ref.observe(DataEventType.value, with: { (snapshot) in
            
            let allValue = snapshot.value as? [String : NSDictionary] ?? [:]
            let allComp = allValue["companies"] as? [String : NSDictionary] ?? [:]
            let allUsers = allValue["users"] as? [String : NSDictionary] ?? [:]
            let currUser = allUsers[self.uid] as? [String : String] ?? [:]
            print("HIIIII " + currUser["currentCompany"]!)
            self.company = currUser["currentCompany"]
            
            let thisComp = allComp[self.company] as? [String : NSDictionary] ?? [:]
            let thisUser = thisComp[self.uid] as? [String : Any] ?? [:]
            var today = thisUser[self.date] as? [String : Any] ?? [:]
            
            let allDates = Array(thisUser.keys)
            self.dates = allDates.filter { $0 != "email" }
            print(self.dates.count)

            for singleDate in self.dates {
                today = thisUser[singleDate] as? [String : Any] ?? [:]
                let todaysTimes = [(today["cIn"] != nil ? (today["cIn"] as! String): ""), (today["mOut"] != nil ? (today["mOut"] as! String): ""), (today["mIn"] != nil ? (today["mIn"] as! String): ""), (today["cOut"] != nil ? (today["cOut"] as! String): "")]
                self.times.append(todaysTimes)
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
        return self.dates.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
        cell.textLabel!.text = self.dates[indexPath.row]
        cell.detailTextLabel?.numberOfLines = 2;
        cell.detailTextLabel?.text = self.times[indexPath.row].joined(separator: ", ")
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
