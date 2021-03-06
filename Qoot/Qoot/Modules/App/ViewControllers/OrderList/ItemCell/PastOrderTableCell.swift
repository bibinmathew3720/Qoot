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
    func cancelOrderButtonActionDelegate(tag:Int)
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
    var delegate:PastOrderTableCellDelegate?
    @IBOutlet weak var itemsListTVHeightCnstrant: NSLayoutConstraint!
    @IBOutlet weak var cancelOrderButton: UIButton!
    
    var dishes:[Dishes]?
    override func awakeFromNib() {
        super.awakeFromNib()
        localisation()
        self.layer.borderColor = Constant.Colors.CommonGreyColor.cgColor
        self.layer.borderWidth = 1.0
        firstTrackView.layer.borderColor = Constant.Colors.CommonGreyColor.cgColor
        firstInnerTrackView.backgroundColor = Constant.Colors.CommonGreyColor
        firstTrackView.layer.borderWidth = 3.0
        secondTrackView.layer.borderColor = Constant.Colors.CommonGreyColor.cgColor
        secondInnerTrackView.backgroundColor = Constant.Colors.CommonGreyColor
        secondTrackView.layer.borderWidth = 3.0
        thirdTrackView.layer.borderColor = Constant.Colors.CommonGreyColor.cgColor
        thirdInnerTrackView.backgroundColor = Constant.Colors.CommonGreyColor
        thirdTrackView.layer.borderWidth = 3.0
        fourthTrackView.layer.borderColor = Constant.Colors.CommonGreyColor.cgColor
        fourthInnerTrackView.backgroundColor = Constant.Colors.CommonGreyColor
        fourthTrackView.layer.borderWidth = 3.0
        itemDetailTable.dataSource = self
        itemDetailTable.delegate = self
        itemDetailTable.register(UINib(nibName: "ItemDetailTableCell", bundle: nil), forCellReuseIdentifier: "itemCell")
    }
    
    func localisation(){
       orderNoTitle.text = "OrderNo".localiz()
       orderOnTiitle.text = "OrderOn".localiz()
        cancelOrderButton.setTitle("CancelOrder".localiz(), for: UIControlState.normal)
    }
    
    @IBAction func expandButtonAction(_ sender: Any) {
    }
    
    @IBAction func cancelOrderButtonAction(_ sender: UIButton) {
        guard let _delegate = delegate else {
            return
        }
        _delegate.cancelOrderButtonActionDelegate(tag: self.tag)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setOrderDetails(orderDetail:Order){
        self.orderNumberLabel.text = "\(orderDetail.orderGroup)"
        self.orderTimeLabel.text = orderDetail.date
        self.priceLabel.text = "SAR".localiz() + " :" + "\(orderDetail.amount)" + "/-"
        self.kitchenTitle.text = orderDetail.kitchenName
        self.dishes = orderDetail.dishes
        itemDetailTable.reloadData()
        switch orderDetail.Status {
        case 0:
            rejectedTitle.text = "OrderPlaced".localiz()
            settingOrderPlacedLayer()
        case 1:
            rejectedTitle.text = "RejectedByTheKitchen".localiz()
            settingRejectedByKitchenLayer()
        case 2:
            rejectedTitle.text = "Preparing".localiz()
            settingPreparingLayer()
        case 3:
            rejectedTitle.text = "CancelledByTheUser".localiz()
            settingCancelledByTheUserLayer()
        case 4:
            rejectedTitle.text = "OnTheWay".localiz()
            settingOnTheWayLayer()
        case 5:
            rejectedTitle.text = "Delivered".localiz()
            settingDeliveredLayer()
        case 6:
            rejectedTitle.text = "RejectedByTheKitchen".localiz()
            settingRejectedByKitchenLayer()
        default:
           rejectedTitle.text = "".localiz()
        }
    }
    
    func settingOrderPlacedLayer(){
        firstTrackView.layer.borderColor = Constant.Colors.CommonGreenColor.cgColor
        firstInnerTrackView.backgroundColor = Constant.Colors.CommonGreenColor
    }
    
    func settingRejectedByKitchenLayer(){
        firstTrackView.layer.borderColor = Constant.Colors.CommonGreenColor.cgColor
        firstInnerTrackView.backgroundColor = Constant.Colors.CommonGreenColor
        secondTrackView.layer.borderColor = Constant.Colors.CommonRedColor.cgColor
        secondInnerTrackView.backgroundColor = Constant.Colors.CommonRedColor
    }
    
    func settingPreparingLayer(){
        firstTrackView.layer.borderColor = Constant.Colors.CommonGreenColor.cgColor
        firstInnerTrackView.backgroundColor = Constant.Colors.CommonGreenColor
    }
    
    func settingCancelledByTheUserLayer(){
        firstTrackView.layer.borderColor = Constant.Colors.CommonGreenColor.cgColor
        firstInnerTrackView.backgroundColor = Constant.Colors.CommonGreenColor
        secondTrackView.layer.borderColor = Constant.Colors.CommonRedColor.cgColor
        secondInnerTrackView.backgroundColor = Constant.Colors.CommonRedColor
    }
    
    func settingOnTheWayLayer(){
        
    }
    
    func settingDeliveredLayer(){
        firstTrackView.layer.borderColor = Constant.Colors.CommonGreenColor.cgColor
        firstInnerTrackView.backgroundColor = Constant.Colors.CommonGreenColor
        secondTrackView.layer.borderColor = Constant.Colors.CommonGreenColor.cgColor
        secondInnerTrackView.backgroundColor = Constant.Colors.CommonGreenColor
        thirdTrackView.layer.borderColor = Constant.Colors.CommonGreenColor.cgColor
        thirdInnerTrackView.backgroundColor = Constant.Colors.CommonGreenColor
        fourthTrackView.layer.borderColor = Constant.Colors.CommonGreenColor.cgColor
        fourthInnerTrackView.backgroundColor = Constant.Colors.CommonGreenColor
    }
}
extension PastOrderTableCell : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dishs = self.dishes{
            return dishs.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemDetailTableCell
        if let dishs = self.dishes{
            cell.setDishes(dish: dishs[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
