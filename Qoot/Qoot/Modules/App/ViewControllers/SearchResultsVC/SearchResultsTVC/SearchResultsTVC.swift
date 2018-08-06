//
//  SearchResultsTVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 8/6/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class SearchResultsTVC: UITableViewCell {
    @IBOutlet weak var customerRatingTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customerRatingTitleLabel.text = "CustomerRating".localiz()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
