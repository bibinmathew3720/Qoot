//
//  OrderListVC.swift
//  Qoot
//
//  Created by Vishnu KM on 06/08/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class OrderListVC: BaseViewController,PastOrderTableCellDelegate {
    var isFromMenu:Bool?
    @IBOutlet var orderListTable: UITableView!
    @IBOutlet var orderSegmentControl: UISegmentedControl!
    var selectedIndex: Int = -1
    var heightConstraint: CGFloat = 0.0
    var buttonBar =  UIView()
    var orderHistoryResponse:QootOrderHistoryResponseModel?
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

    @IBAction func segmentControlClickAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = ((self.orderSegmentControl.frame.width / CGFloat(self.orderSegmentControl.numberOfSegments)) * CGFloat(self.orderSegmentControl.selectedSegmentIndex))
        }
    }
  
    func expandButtonActionDelegate(with tag: Int, tableheight: CGFloat) {
        selectedIndex = tag
        heightConstraint = tableheight
        orderListTable.reloadData()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension OrderListVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PastOrderTableCell
        cell.delegate = self
        cell.tag = indexPath.section
        if selectedIndex == indexPath.section{
            cell.tableViewHeightConstraint.constant = heightConstraint
        }
        else{
            cell.tableViewHeightConstraint.constant = 0.0
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
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
