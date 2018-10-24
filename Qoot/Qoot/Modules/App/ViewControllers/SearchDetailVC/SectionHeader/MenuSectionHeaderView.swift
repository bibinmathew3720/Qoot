//
//  MenuSectionHeaderView.swift
//  Qoot
//
//  Created by Nimmy K Das on 10/24/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit
protocol MenuSectionHeaderViewDelegate {
    func arrowButtonDelegateAction(with tag:Int) -> ()
}
class MenuSectionHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var containerView: UIView!
     var delegate:MenuSectionHeaderViewDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func arrowButtonAction(_ sender: Any) {
        guard let _delegate = delegate else {
            return
        }
        _delegate.arrowButtonDelegateAction(with: self.tag)
    }
}
