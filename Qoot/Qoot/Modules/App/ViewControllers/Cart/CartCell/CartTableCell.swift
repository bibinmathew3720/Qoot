//
//  CartTableCell.swift
//  Qoot
//
//  Created by Vishnu KM on 06/08/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit
protocol CartTableCellDelegate {
    func plusButtonActionDelegate(with tag:Int) -> ()
     func minusButtonActionDelegate(with tag:Int) -> ()
}
class CartTableCell: UITableViewCell {
    
    @IBOutlet var countLabel: UILabel!
    var delegate:CartTableCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCartModel(index:Int, selectedIndex:Int, value:String) ->(){
        if index == selectedIndex{
            countLabel.text = value
        }
    }
    
    @IBAction func minusButtonAction(_ sender: Any) {
        guard let _delegate = delegate else {
            return
        }
        _delegate.minusButtonActionDelegate(with: self.tag)
    }
    
    @IBAction func plusButtonAction(_ sender: Any) {
        guard let _delegate = delegate else {
            return
        }
        _delegate.plusButtonActionDelegate(with: self.tag)
    }
}
