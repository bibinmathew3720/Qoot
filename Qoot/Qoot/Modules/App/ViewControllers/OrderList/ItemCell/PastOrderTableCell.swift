//
//  PastOrderTableCell.swift
//  Qoot
//
//  Created by Vishnu KM on 06/08/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit
protocol PastOrderTableCellDelegate {
    func expandButtonActionDelegate(with tag:Int, tableheight: CGFloat) -> ()
}
class PastOrderTableCell: UITableViewCell {

    @IBOutlet var orderNumberLabel: UILabel!
    @IBOutlet var orderNoTitle: UILabel!
    @IBOutlet var orderOnTiitle: UILabel!
    @IBOutlet var kitchenTitle: UILabel!
    @IBOutlet var orderTimeLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var rejectedTitle: UILabel!
    @IBOutlet var itemDetailTable: UITableView!
    @IBOutlet var thirdTrackView: UIView!
    @IBOutlet var fourthInnerTrackView: UIView!
    @IBOutlet var thirdInnerTrackView: UIView!
    @IBOutlet var secondInnerTrackView: UIView!
    @IBOutlet var firstInnerTrackView: UIView!
    @IBOutlet var fourthTrackView: UIView!
    @IBOutlet var secondTrackView: UIView!
    @IBOutlet var firstTrackView: UIView!
    var rowCount:CGFloat = 0
    var delegate:PastOrderTableCellDelegate?
    @IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
        firstTrackView.layer.borderColor = UIColor.darkGray.cgColor
        firstTrackView.layer.borderWidth = 3.0
        secondTrackView.layer.borderColor = UIColor.darkGray.cgColor
        secondTrackView.layer.borderWidth = 3.0
        thirdTrackView.layer.borderColor = UIColor.darkGray.cgColor
        thirdTrackView.layer.borderWidth = 3.0
        fourthTrackView.layer.borderColor = UIColor.darkGray.cgColor
        fourthTrackView.layer.borderWidth = 3.0
    }
    @IBAction func expandButtonAction(_ sender: Any) {
        rowCount = 3
        guard let _delegate = delegate else {
            return
        }
        _delegate.expandButtonActionDelegate(with: self.tag, tableheight: rowCount * 40)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension PastOrderTableCell : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(rowCount)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemDetailTableCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
