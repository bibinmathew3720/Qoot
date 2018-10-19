//
//  OrderConfirmVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 9/9/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class OrderConfirmVC: BaseViewController {
    @IBOutlet weak var orderCompletedLabel: UILabel!
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var gotoMyOrdersButton: UIButton!
    
    var customerOrderResponse:AddCustomerOrderResponseModel?
    override func initView() {
        initialisation()
        localization()
        addingLeftBarButton()
        self.leftButton?.setImage(UIImage.init(named: ""), for: UIControlState.normal)
        addingHomeBarButton()
    }
    
    func initialisation(){
        if let orderResponse = customerOrderResponse{
            orderNumberLabel.text = "OrderNumber".localiz() + " " + "\(orderResponse.order_Id)"
        }
    }
    
    func localization(){
        self.title = "Qoot".localiz()
        orderCompletedLabel.text = "OrderCompleted".localiz()
        gotoMyOrdersButton.setTitle("GOTOMYORDERS".localiz(), for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func gotoMyOrdersButtonAction(_ sender: UIButton) {
        let orderListVC:OrderListVC = OrderListVC(nibName: "OrderListVC", bundle: nil)
        orderListVC.isFromMenu = false
        self.navigationController?.pushViewController(orderListVC, animated: true)
    }
    
    override func homeButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func leftNavButtonAction() {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
