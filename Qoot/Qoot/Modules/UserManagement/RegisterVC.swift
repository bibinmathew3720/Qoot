//
//  RegisterVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 8/2/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class RegisterVC: BaseViewController,UITextFieldDelegate {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneNoTF: UITextField!
    @IBOutlet weak var pwdTF: UITextField!
    @IBOutlet weak var confirmPwdTF: UITextField!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var maleLabel: UILabel!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var femaleLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    override func initView() {
        initialisation()
        localisation()
    }
    
    func initialisation(){
        self.title = "RegisterTitle".localiz()
        addingLeftBarButton()
    }
    
    func localisation(){
       nameTF.placeholder = "NamePlaceholder".localiz()
       emailTF.placeholder = "EmailPlaceholder".localiz()
       phoneNoTF.placeholder = "MobNoPlaceholder".localiz()
       pwdTF.placeholder = "PwdPlaceholder".localiz()
       confirmPwdTF.placeholder = "ConfirmPwdPlaceholder".localiz()
       maleLabel.text = "Male".localiz()
       femaleLabel.text = "Female".localiz()
       submitButton.setTitle("SIGNUP".localiz(), for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Actions
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    @IBAction func maleButtonAction(_ sender: UIButton) {
        sender.isSelected = true
        femaleButton.isSelected = false
    }
    
    @IBAction func femaleButtonAction(_ sender: UIButton) {
        sender.isSelected = true
        maleButton.isSelected = false
    }
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constant.SegueIdentifiers.registerToOTP, sender: self)
//        if isValidInputs(){
//           callingSignUpApi()
//        }
    }
    
    //MARK: Validation
    
    func isValidInputs()->Bool{
        var valid = true
        var message = ""
        if (nameTF.text?.isEmpty)!{
            message = "FILLMANDATORYFIELDS".localiz()
            valid = false
        }
        else if (emailTF.text?.isEmpty)!{
            message = "FILLMANDATORYFIELDS".localiz()
            valid = false
        }
        else if (phoneNoTF.text?.isEmpty)!{
            message = "FILLMANDATORYFIELDS".localiz()
            valid = false
        }
        else if (pwdTF.text?.isEmpty)!{
            message = "FILLMANDATORYFIELDS".localiz()
            valid = false
        }
        else if (confirmPwdTF.text?.isEmpty)!{
            message = "FILLMANDATORYFIELDS".localiz()
            valid = false
        }
        else if (pwdTF.text != confirmPwdTF.text){
            message = "PASSWORDSDOESNOTMATCHES".localiz()
            valid = false
        }
        else if ((pwdTF.text?.count)!<8){
            message = "INVALIDPASSWORDCHARACTERS".localiz()
            valid = false
        }
        else if !(emailTF.text?.isValidEmail())!{
            message = "INVALIDEMAIL".localiz()
            valid = false
        }
        if (!valid){
            CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: message, parentController: self)
        }
        return valid
    }
    
    //MARK: UITextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.nameTF {
            emailTF.becomeFirstResponder()
        }
        else if textField == self.emailTF {
            phoneNoTF.becomeFirstResponder()
        }
        else if textField == self.phoneNoTF {
            pwdTF.becomeFirstResponder()
        }
        else if textField == self.pwdTF {
            confirmPwdTF.becomeFirstResponder()
        }
        else{
            textField.resignFirstResponder()
        }
       return true
    }
    
    //MARK: Sign Up Api
    
    func  callingSignUpApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingSignUpApi(with: getRegisterRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? QootRegisterResponseModel{
                if model.statusCode == 1{
                    CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: model.errorMessage, parentController: self)
                }
                else{
                    CCUtility.showDefaultAlertwithCompletionHandler(_title: Constant.AppName, _message: model.statusMessage, parentController: self, completion: { (okSuccess) in
                            self.navigationController?.popViewController(animated: true)
                    })
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
    
    func getRegisterRequestBody()->String{
        var dict:[String:String] = [String:String]()
        if let name = self.nameTF.text {
            dict.updateValue(name, forKey: "Name")
        }
        if let email = self.emailTF.text {
            dict.updateValue(email, forKey: "Email")
        }
        if let phone = self.phoneNoTF.text {
            dict.updateValue(phone, forKey: "Phone")
        }
        if let password = self.pwdTF.text {
            dict.updateValue(password, forKey: "Password")
        }
        dict.updateValue("Direct", forKey: "RegType")
        return CCUtility.getJSONfrom(dictionary: dict)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.SegueIdentifiers.registerToOTP{
            let otpVC = segue.destination as! OTPVC
            otpVC.mobNoString = self.phoneNoTF.text
        }
    }
   
}
