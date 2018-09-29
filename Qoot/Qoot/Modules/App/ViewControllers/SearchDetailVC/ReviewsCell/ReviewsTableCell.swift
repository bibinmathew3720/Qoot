//
//  ReviewsTableCell.swift
//  Qoot
//
//  Created by Vishnu KM on 10/08/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class ReviewsTableCell: UITableViewCell {
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCustomerRating(customerRating:KitchenCustomerRating){
       self.nameLabel.text = customerRating.customerName
        self.commentLabel.text = customerRating.customerComment
        setRatingCount(count: customerRating.customerRating)
    }
    
    func setRatingCount(count:Int){
        star1.isSelected = false
        star2.isSelected = false
        star3.isSelected = false
        star4.isSelected = false
        star5.isSelected = false
        if count == 1{
            star1.isSelected = true
        }
        else if count == 2 {
           star1.isSelected = true
           star2.isSelected = true
        }
        else if count == 3 {
            star1.isSelected = true
            star2.isSelected = true
            star3.isSelected = true
        }
        else if count == 4 {
            star1.isSelected = true
            star2.isSelected = true
            star3.isSelected = true
            star4.isSelected = true
        }
        else if count >= 5{
            star1.isSelected = true
            star2.isSelected = true
            star3.isSelected = true
            star4.isSelected = true
            star5.isSelected = true
        }
    }
    
}
