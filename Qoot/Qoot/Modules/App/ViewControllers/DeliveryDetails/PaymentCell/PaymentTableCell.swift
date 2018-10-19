//
//  PaymentTableCell.swift
//  Qoot
//
//  Created by Vishnu KM on 07/08/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit
protocol PaymentTableCellDelegate {
    func paymentButtonDelegateAction(with tag:Int) -> ()
}
class PaymentTableCell: UITableViewCell {
    
    @IBOutlet var paymentSelectionButton: UIButton!
    @IBOutlet var paymentTypeLabel: UILabel!
    @IBOutlet weak var paymentTypeImageView: UIImageView!
    var delegate:PaymentTableCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setModel(index:Int,selectedIndex:Int) -> () {
        if index == 0 {
            paymentTypeLabel.textColor = UIColor.black
            paymentSelectionButton.isUserInteractionEnabled = true
        }
        else{
            paymentTypeLabel.textColor = UIColor.lightGray
            paymentSelectionButton.isUserInteractionEnabled = false
        }
        if index == selectedIndex{
            paymentSelectionButton.isSelected = true
        }
        else{
            paymentSelectionButton.isSelected = false
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func paymentButtonAction(_ sender: Any) {
        guard let _delegate = delegate else {
            return
        }
        _delegate.paymentButtonDelegateAction(with: self.tag)
    }
}
