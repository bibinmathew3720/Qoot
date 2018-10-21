//
//  AddressTableCell.swift
//  Qoot
//
//  Created by Vishnu KM on 07/08/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

protocol AddressCellDelegate {
    func closeButtonDelegateAction(with tag:Int) -> ()
    func editButtonDelegateAction(with tag:Int) -> ()
}

class AddressTableCell: UITableViewCell {
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var addressNameLabel: UILabel!
    @IBOutlet weak var addressSubNameLabel: UILabel!
    var delegate:AddressCellDelegate?
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
    
    //Button Action
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        guard let _delegate = delegate else {
            return
        }
        _delegate.closeButtonDelegateAction(with: self.tag)
    }
    
    @IBAction func editButtonAction(_ sender: UIButton) {
        guard let _delegate = delegate else {
            return
        }
        _delegate.editButtonDelegateAction(with: self.tag)
    }
}
