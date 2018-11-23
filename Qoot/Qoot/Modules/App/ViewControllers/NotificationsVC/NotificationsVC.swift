//
//  NotificationsVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 11/24/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class NotificationsVC: BaseViewController {

    override func initView() {
        super.initView()
        initialisation()
        localisation()
    }
    
    func initialisation(){
        addingLeftBarButton()
    }
    
    func localisation(){
        self.title = "Notifications".localiz()
    }
    
    override func leftNavButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
