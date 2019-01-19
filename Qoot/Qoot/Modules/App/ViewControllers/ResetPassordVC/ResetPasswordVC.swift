//
//  ResetPasswordVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 1/19/19.
//  Copyright © 2019 Cl. All rights reserved.
//

import UIKit

class ResetPasswordVC: BaseViewController {
    var checkOTPResponse:CheckOTPResponseModel?
    override func initView() {
        super.initView()
        initialisation()
        localisation()
    }
    
    func initialisation(){
        addingLeftBarButton()
    }
    
    func localisation(){
        //self.title = "RecoverAccount".localiz()
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
