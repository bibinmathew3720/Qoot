//
//  ReviewsHeaderView.swift
//  Qoot
//
//  Created by Nimmy K Das on 8/9/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class ReviewsHeaderView: UIView {

    @IBOutlet var reviewsTable: UITableView!
    @IBOutlet var deliveryView: UIView!
    @IBOutlet var moneyView: UIView!
    @IBOutlet var packagingView: UIView!
    @IBOutlet var qualityView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
         
        deliveryView.layer.borderWidth = 3.0
        deliveryView.layer.borderColor = UIColor(red:0.58, green:0.76, blue:0.12, alpha:1.0).cgColor
        moneyView.layer.borderWidth = 3.0
        moneyView.layer.borderColor = UIColor(red:0.58, green:0.76, blue:0.12, alpha:1.0).cgColor
        packagingView.layer.borderWidth = 3.0
        packagingView.layer.borderColor = UIColor(red:0.58, green:0.76, blue:0.12, alpha:1.0).cgColor
        qualityView.layer.borderWidth = 3.0
        qualityView.layer.borderColor = UIColor(red:0.58, green:0.76, blue:0.12, alpha:1.0).cgColor
        reviewsTable.register(UINib.init(nibName: "ReviewsTableCell", bundle: nil), forCellReuseIdentifier: "reviewsCell")
    }
  
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reviewsCell", for: indexPath) as! ReviewsTableCell
            return cell
        }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableViewAutomaticDimension
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        }
 
}

