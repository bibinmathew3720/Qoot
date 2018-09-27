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
    var delegate:PastOrderTableCellDelegate?
    
    var dishes:[Dishes]?
    override func awakeFromNib() {
        super.awakeFromNib()
        localisation()
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
        itemDetailTable.dataSource = self
        itemDetailTable.delegate = self
        itemDetailTable.register(UINib(nibName: "ItemDetailTableCell", bundle: nil), forCellReuseIdentifier: "itemCell")
    }
    
    func localisation(){
       orderNoTitle.text = "OrderNo".localiz()
       orderOnTiitle.text = "OrderOn".localiz()
    }
    
    @IBAction func expandButtonAction(_ sender: Any) {
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
