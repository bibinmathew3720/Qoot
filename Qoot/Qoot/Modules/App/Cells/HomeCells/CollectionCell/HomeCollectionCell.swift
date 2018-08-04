//
//  HomeCollectionCell.swift
//  DemoPgm
//
//  Created by Vishnu KM on 03/08/18.
//  Copyright © 2018 Vishnu KM. All rights reserved.
//

import UIKit

class HomeCollectionCell: UICollectionViewCell {
    @IBOutlet var priceLabel: UILabel!
    
    @IBOutlet var itemNameLabel: UILabel!
    @IBOutlet var viewMoreLabel: UILabel!
    @IBOutlet var itemIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        itemIcon.layer.borderColor = UIColor.black.cgColor
        itemIcon.layer.borderWidth = 1.0
    }

}
