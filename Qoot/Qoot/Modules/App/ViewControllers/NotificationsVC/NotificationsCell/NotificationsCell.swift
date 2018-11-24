//
//  NotificationsCell.swift
//  Qoot
//
//  Created by Bibin Mathew on 11/24/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class NotificationsCell: UITableViewCell {
    @IBOutlet weak var refNoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setNotification(notification:Notifications){
        dateLabel.text = notification.notificationDate
        descriptionLabel.text = notification.notMessage
        refNoLabel.text = "refNo".localiz() + ": \(notification.referenceNo)"
    }
    
}
