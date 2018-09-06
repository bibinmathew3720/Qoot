//
//  ReviewsHeaderView.swift
//  Qoot
//
//  Created by Nimmy K Das on 8/9/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class ReviewsHeaderView: UIView {
    @IBOutlet weak var reviewsHeadingLabel: UILabel!
    @IBOutlet weak var qualityRateLabel: UILabel!
    @IBOutlet weak var packingRateLabel: UILabel!
    @IBOutlet weak var moneyRateLabel: UILabel!
    @IBOutlet weak var deliveryTimeRateLabel: UILabel!
    @IBOutlet weak var qualityHeadingLabel: UILabel!
    @IBOutlet weak var packagingHeadingLabel: UILabel!
    @IBOutlet weak var moneyHeadingLabel: UILabel!
    @IBOutlet weak var deliveryTimeHeadingLabel: UILabel!
    
    @IBOutlet var reviewsTable: UITableView!
    @IBOutlet var deliveryView: UIView!
    @IBOutlet var moneyView: UIView!
    @IBOutlet var packagingView: UIView!
    @IBOutlet var qualityView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        localisation()
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
    
    func localisation(){
        reviewsHeadingLabel.text = "Reviews".localiz()
        qualityHeadingLabel.text = "Quality".localiz()
        packagingHeadingLabel.text = "Packaging".localiz()
        moneyHeadingLabel.text = "Value For Money".localiz()
        deliveryTimeHeadingLabel.text = "Delivery Time".localiz()
    }
    
    func setAdminRating(adminRating:KitchenAdminRatingResponseModel){
        self.qualityRateLabel.text = String(format: "%0.1f", adminRating.quality)
        self.packingRateLabel.text = String(format: "%0.1f", adminRating.packing)
        self.moneyRateLabel.text = String(format: "%0.1f", adminRating.money)
        self.deliveryTimeRateLabel.text = String(format: "%0.1f", adminRating.delivery)
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

