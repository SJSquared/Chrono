//
//  CellController.swift
//  Chrono
//
//  Created by iGuest on 12/11/17.
//  Copyright © 2017 SJSquared. All rights reserved.
//
import UIKit

class CellController: UITableViewCell {
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var employeeEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
