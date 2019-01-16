//
//  ForgotPasswordVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 1/16/19.
//  Copyright © 2019 Cl. All rights reserved.
//

import UIKit

class ForgotPasswordVC: BaseViewController {
    @IBOutlet weak var phoneNoTF: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func initView() {
        super.initView()
        initialisation()
        localisation()
    }
    
    func initialisation(){
        addingLeftBarButton()
    }
    
    func localisation(){
       self.title = "RecoverAccount".localiz()
       phoneNoTF.placeholder = "MobNoPlaceholder".localiz()
       nextButton.setTitle("Next".localiz(), for: UIControlState.normal)
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
