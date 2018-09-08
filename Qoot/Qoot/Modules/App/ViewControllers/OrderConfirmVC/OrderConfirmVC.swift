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
    
    override func initView() {
        initialisation()
        localization()
        addingHomeBarButton()
    }
    
    func initialisation(){
       
    }
    
    func localization(){
        self.title = "Qoot".localiz()
        orderCompletedLabel.text = "OrderCompleted".localiz()
        orderNumberLabel.text = "OrderNumber".localiz() + "131231331"
        gotoMyOrdersButton.setTitle("GOTOMYORDERS".localiz(), for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func gotoMyOrdersButtonAction(_ sender: UIButton) {
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
