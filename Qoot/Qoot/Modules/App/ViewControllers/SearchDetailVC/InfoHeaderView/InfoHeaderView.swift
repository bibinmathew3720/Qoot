//
//  InfoHeaderView.swift
//  Qoot
//
//  Created by Nimmy K Das on 8/9/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class InfoHeaderView: UIView {
    @IBOutlet weak var eventServiceButton: UIButton!
    @IBOutlet weak var deliveryServiceButton: UIButton!
    @IBOutlet weak var locationTitleLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var deliveryServiceLabel: UILabel!
    @IBOutlet weak var eventServiceLabel: UILabel!
    @IBOutlet weak var qootRatingTitleLabel: UILabel!
    @IBOutlet weak var customerRatingTitleLabel: UILabel!
    @IBOutlet weak var customerRatingLabel: UILabel!
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        localization()
    }
    
    func localization(){
        locationTitleLabel.text = "Location".localiz()
        deliveryServiceLabel.text = "Delivery Service".localiz()
        eventServiceLabel.text = "Event Service".localiz()
        qootRatingTitleLabel.text = "Qoot Rating".localiz()
        customerRatingTitleLabel.text = "Customer Rating".localiz()
    }
    
    func setKitchenInfo(kitchenInfo:ViewKitchensInfo){
        self.locationNameLabel.text = kitchenInfo.Location
        self.deliveryServiceButton.isSelected = kitchenInfo.Delivery
        self.eventServiceButton.isSelected = kitchenInfo.Event
        self.customerRatingLabel.text = String(format: "%0.1f", kitchenInfo.customerRating)
        setRatingStar(count: kitchenInfo.QootRating)
    }
    
    func setRatingStar(count:Int){
        star1.isSelected = false
        star2.isSelected = false
        star3.isSelected = false
        star4.isSelected = false
        star5.isSelected = false
        if count == 1{
            star1.isSelected = true
        }
        else if count == 2 {
            star1.isSelected = true
            star2.isSelected = true
        }
        else if count == 3 {
            star1.isSelected = true
            star2.isSelected = true
            star3.isSelected = true
        }
        else if count == 4 {
            star1.isSelected = true
            star2.isSelected = true
            star3.isSelected = true
            star4.isSelected = true
        }
        else if count >= 5{
            star1.isSelected = true
            star2.isSelected = true
            star3.isSelected = true
            star4.isSelected = true
            star5.isSelected = true
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
