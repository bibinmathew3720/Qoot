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
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        if isValidInputs(){
            callingSendOTPApi()
        }
    }
    
    //MARK: Validation
    
    func isValidInputs()->Bool{
        var valid = true
        var message = ""
         if let mobString = phoneNoTF.text{
            if mobString.count < 6{
                message = "ENTERVALIDMOBILENO".localiz()
                valid = false
            }
        }
        if (!valid){
            CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: message, parentController: self)
        }
        return valid
    }
    
    //MARK: Send OTP Api
    
    func  callingSendOTPApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingSendOTPApi(with: getSendOTPRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? SendOTPResponseModel{
                if model.status ==  1 {
                    self.showOTPVC()
                }
                else{
                    CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: model.statusMessage, parentController: self)
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
    
    func getSendOTPRequestBody()->String{
        var dataString:String = ""
        if let mobString = phoneNoTF.text{
            let phString:String = "Phone=\(mobString.urlEncode())"
            dataString = dataString + phString + "&"
        }
        return dataString
    }
    
    func showOTPVC(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let otpVC = storyboard.instantiateViewController(withIdentifier: "OTPVC") as? OTPVC
        otpVC?.mobNoString = self.phoneNoTF.text
        self.navigationController?.pushViewController(otpVC!, animated: true)
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
