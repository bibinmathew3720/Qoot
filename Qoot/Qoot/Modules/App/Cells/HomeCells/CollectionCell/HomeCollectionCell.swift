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
    @IBOutlet var dishNameLabel: UILabel!
    @IBOutlet var dishImage: UIImageView!
    @IBOutlet weak var priceBackView: UIView!
    
    @IBOutlet var viewMoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dishImage.layer.borderColor = Constant.Colors.CommonBlackColor.cgColor
        dishImage.layer.borderWidth = 0.5
        viewMoreLabel.text = "ViewMore".localiz()
    }
    
    func setDish(dish:Dishes){
        setDishControls()
        dishNameLabel.text = dish.DishName
        priceLabel.text = "SAR".localiz() + " " + String(format: "%.2f", dish.DishAmount)
        dishImage.sd_setImage(with: URL(string: dish.DishImage), placeholderImage: UIImage(named: Constant.ImageNames.placeholderImage))
    }
    
    func setDishControls(){
        viewMoreLabel.isHidden = true
        dishNameLabel.isHidden = false
        dishImage.backgroundColor = UIColor.clear
        priceLabel.isHidden = false
        priceBackView.isHidden = false
    }
    
    func hideDishControls(){
        viewMoreLabel.isHidden = false
        dishNameLabel.isHidden = true
        dishImage.backgroundColor = Constant.Colors.CommonMeroonColor
        priceLabel.isHidden = true
        priceBackView.isHidden = true
    }

}
