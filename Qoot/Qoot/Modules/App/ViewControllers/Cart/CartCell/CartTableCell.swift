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
    func closeButtonActionDelegate(with tag:Int)->()
}
class CartTableCell: UITableViewCell {
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
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
    
    func setCartModel(cart:Cart) ->(){
        dishNameLabel.text = cart.productName
        priceLabel.text = String(format: "%0.2f", cart.productPrice)
        countLabel.text = String(format: "%d", cart.productCount)
        //if index == selectedIndex{
        
       // }
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
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        guard let _delegate = delegate else {
            return
        }
        _delegate.closeButtonActionDelegate(with: self.tag)
    }
}
