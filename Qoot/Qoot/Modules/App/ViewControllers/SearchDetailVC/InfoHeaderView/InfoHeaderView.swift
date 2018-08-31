//
//  InfoHeaderView.swift
//  Qoot
//
//  Created by Nimmy K Das on 8/9/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class InfoHeaderView: UIView {
    @IBOutlet weak var locationTitleLabel: UILabel!
    @IBOutlet weak var deliveryServiceLabel: UILabel!
    @IBOutlet weak var eventServiceLabel: UILabel!
    @IBOutlet weak var qootRatingTitleLabel: UILabel!
    @IBOutlet weak var customerRatingTitleLabel: UILabel!
    var viewKitchensInfo:ViewKitchensInfo?
    
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
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
