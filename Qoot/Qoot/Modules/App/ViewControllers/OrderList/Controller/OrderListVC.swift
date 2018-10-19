//
//  OrderListVC.swift
//  Qoot
//
//  Created by Vishnu KM on 06/08/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

enum OrderType{
    case ongoingOrder
    case pastOrder
}

class OrderListVC: BaseViewController,PastOrderTableCellDelegate {
    var isFromMenu:Bool?
    @IBOutlet var orderListTable: UITableView!
    @IBOutlet var orderSegmentControl: UISegmentedControl!
    var selectedIndex: Int = -1
    var heightConstraint: CGFloat = 0.0
    var buttonBar =  UIView()
    var orderHistoryResponse:QootOrderHistoryResponseModel?
    var orderType = OrderType.ongoingOrder
    
    var ongoingOrderArray = [Order]()
    var pastOrderArray = [Order]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialisation()
        localization()
        getOrderListApi()
        // Do any additional setup after loading the view.
    }

    func initialisation(){
        orderListTable.register(UINib(nibName: "PastOrderTableCell", bundle: nil), forCellReuseIdentifier: "Cell")
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.backgroundColor = UIColor(red:0.64, green:0.10, blue:0.36, alpha:1.0)
        view.addSubview(buttonBar)
        buttonBar.topAnchor.constraint(equalTo: orderSegmentControl.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        buttonBar.leftAnchor.constraint(equalTo: orderSegmentControl.leftAnchor).isActive = true
        buttonBar.widthAnchor.constraint(equalTo: orderSegmentControl.widthAnchor, multiplier: 1 / CGFloat(orderSegmentControl.numberOfSegments)).isActive = true
        orderSegmentControl.selectedSegmentIndex = 0
        orderSegmentControl.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.black,NSAttributedStringKey.font: UIFont(name: Constant.Font.Bold, size: 17)!], for: .selected)
        orderSegmentControl.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.black,NSAttributedStringKey.font: UIFont(name: Constant.Font.Bold, size: 17)!], for: .normal)
        
        addingLeftBarButton()
    }
    
    func localization(){
        self.title = "MyOrders".localiz()
        orderSegmentControl.setTitle("OngoingOrders".localiz(), forSegmentAt: 0)
        orderSegmentControl.setTitle("PastOrders".localiz(), forSegmentAt: 1)
    }

    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = ((self.orderSegmentControl.frame.width / CGFloat(self.orderSegmentControl.numberOfSegments)) * CGFloat(self.orderSegmentControl.selectedSegmentIndex))
        }
        if sender.selectedSegmentIndex == 0 {
            self.orderType = OrderType.ongoingOrder
        }
        else{
            self.orderType = OrderType.pastOrder
        }
        orderListTable.reloadData()
    }
    
    //Order Cell Delegate
  
    func expandButtonActionDelegate(with tag: Int, tableheight: CGFloat) {
        selectedIndex = tag
        heightConstraint = tableheight
        orderListTable.reloadData()
    }
    
    func cancelOrderButtonActionDelegate(tag: Int) {
        let orderID = self.ongoingOrderArray[tag].orderGroup
        let messageString = "DOYOUWANTTOCANCELORDER".localiz() + " \(orderID)"
        let alertController = UIAlertController(title: "AREYOUSURE".localiz(), message: messageString, preferredStyle: .alert)
        let noAction = UIAlertAction(title: "NO".localiz(), style: .default) { (action:UIAlertAction) in
            
        }
        let yesAction = UIAlertAction(title: "YES".localiz(), style: .default) { (action:UIAlertAction) in
            self.cancelOrderApi(orderIndex: tag)
        }
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        self.present(alertController, animated: true) {
        }
    }
    
    //Button Actions
    
    override func leftNavButtonAction() {
        if let isMenu = self.isFromMenu{
            self.dismiss(animated: true, completion: nil)
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func getOrderListApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        CartManager().callingGetOrderListApi(with:getOrderListRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? QootOrderHistoryResponseModel{
               self.orderHistoryResponse = model
                self.populateOrderList()
            }
        }) { (ErrorType) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if(ErrorType == .noNetwork){
                CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: Constant.ErrorMessages.noNetworkMessage, parentController: self)
            }
            else{
                CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: Constant.ErrorMessages.serverErrorMessamge, parentController: self)
            }
            
            print(ErrorType)
        }
    }
    
    func getOrderListRequestBody()->String{
        var dataString:String = ""
        if let user = User.getUser() {
            let customerId:String = "CustomerId=\(String(user.userId))"
            dataString = dataString + customerId
        }
        return dataString
    }
    
    func populateOrderList(){
        if let orderHistory = self.orderHistoryResponse{
            self.ongoingOrderArray = orderHistory.orderArray.filter({($0.Status == 0 || $0.Status == 2 || $0.Status == 4)})
            self.pastOrderArray = orderHistory.orderArray.filter({($0.Status == 1 || $0.Status == 3 || $0.Status == 5 || $0.Status == 6)})
            self.orderListTable.reloadData()
        }
    }
    
    //MARK: Cancel Order Api
    
    func cancelOrderApi(orderIndex:Int){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let orderID = self.ongoingOrderArray[orderIndex].orderId
        CartManager().cancelOrderApi(with:getCancelOrderRequestBody(orderId: orderID), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? QootOrderHistoryResponseModel{
                if let orderHistory = self.orderHistoryResponse{
                    let filArray = orderHistory.orderArray.filter({($0.orderId == orderID)})
                    let order = filArray.first
                    if let odr = order{
                        odr.Status = 3
                    }
                    self.populateOrderList()
                }
                
            }
        }) { (ErrorType) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if(ErrorType == .noNetwork){
                CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: Constant.ErrorMessages.noNetworkMessage, parentController: self)
            }
            else{
                CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: Constant.ErrorMessages.serverErrorMessamge, parentController: self)
            }
            
            print(ErrorType)
        }
    }
    
    func getCancelOrderRequestBody(orderId:Int)->String{
        var dataString:String = ""
        if let user = User.getUser() {
            let customerId:String = "CustomerId=\(String(user.userId))"
            dataString = dataString + customerId
        }
        return dataString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension OrderListVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if orderType == OrderType.ongoingOrder{
            return ongoingOrderArray.count
        }
        else if orderType == OrderType.pastOrder{
            return pastOrderArray.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PastOrderTableCell
        cell.delegate = self
        cell.tag = indexPath.section
//        if selectedIndex == indexPath.section{
//            cell.tableViewHeightConstraint.constant = heightConstraint
//        }
//        else{
//            cell.tableViewHeightConstraint.constant = 0.0
//        }
        if orderType == OrderType.ongoingOrder{
            cell.setOrderDetails(orderDetail:ongoingOrderArray[indexPath.section])
            cell.cancelOrderButton.isHidden = false
        }
        else if orderType == OrderType.pastOrder{
           cell.setOrderDetails(orderDetail:pastOrderArray[indexPath.section])
           cell.cancelOrderButton.isHidden = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 10))
        view.backgroundColor = .clear
        return view
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
