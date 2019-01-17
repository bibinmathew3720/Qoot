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
    
    @IBOutlet weak var kitchenImageView: UIImageView!
    @IBOutlet weak var kitchenNameLabel: UILabel!
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var closedLabel: UILabel!
    @IBOutlet weak var closedStatusView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        settingBorderToImageview()
        customerRatingTitleLabel.text = "CustomerRating".localiz()
        closedLabel.text = "Closed".localiz()
        // Initialization code
    }
    
    func settingBorderToImageview(){
        kitchenImageView.layer.borderColor = Constant.Colors.CommonBlackColor.cgColor
        kitchenImageView.layer.borderWidth = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setKitchen(kitchen:ViewKitchens){
         kitchenImageView.sd_setImage(with: URL(string: kitchen.KitchenLogo), placeholderImage: UIImage(named: Constant.ImageNames.placeholderImage))
        kitchenNameLabel.text = kitchen.KitchenName
        
        ratingLabel.text = String(format: "%.1f", kitchen.CutomerRating)
        setRating(rating: kitchen.AdminRating)
        if !kitchen.OpenStatus{
            self.closedStatusView.isHidden = false
        }
        else{
           self.closedStatusView.isHidden = true
        }
    }
    
    func setRating(rating:Int){
        unselectingAllRatingButtons()
        if rating == 1{
           star1.isSelected = true
        }
        else if rating == 2 {
            star1.isSelected = true
            star2.isSelected = true
        }
        else if rating == 3 {
            star1.isSelected = true
            star2.isSelected = true
            star3.isSelected = true
        }
        else if rating == 4 {
            star1.isSelected = true
            star2.isSelected = true
            star3.isSelected = true
            star4.isSelected = true
        }
        else if rating == 5 {
            star1.isSelected = true
            star2.isSelected = true
            star3.isSelected = true
            star4.isSelected = true
            star5.isSelected = true
        }
    }
    
    func unselectingAllRatingButtons(){
        star1.isSelected = false
        star2.isSelected = false
        star3.isSelected = false
        star4.isSelected = false
        star5.isSelected = false
    }
}
