//
//  AddressTableCell.swift
//  Qoot
//
//  Created by Vishnu KM on 07/08/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class AddressTableCell: UITableViewCell {
    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var addressNameLabel: UILabel!
    @IBOutlet weak var addressSubNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setAddress(address:Address){
        addressNameLabel.text = address.customerLocationName
        addressSubNameLabel.text = address.deliveryLandMark
    }
    
}
