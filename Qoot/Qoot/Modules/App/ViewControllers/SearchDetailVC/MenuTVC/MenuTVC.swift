//
//  MenuTVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 8/6/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class MenuTVC: UITableViewCell {
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var dishDesLabel: UILabel!
    @IBOutlet weak var priceLbael: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDishDetails(dish:Dishes) {
        dishNameLabel.text = dish.DishName
        dishDesLabel.text = dish.DishDescription
        priceLbael.text = "SAR".localiz() + " \(dish.DishAmount)"
        dishImageView.sd_setImage(with: URL(string: dish.DishImage), placeholderImage: UIImage(named: Constant.ImageNames.placeholderImage))
    }
    
}
