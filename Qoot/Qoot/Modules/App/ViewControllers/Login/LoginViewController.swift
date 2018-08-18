//
//  LoginViewController.swift
//  Qoot
//
//  Created by Vishnu KM on 12/08/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController,UITextFieldDelegate {
    @IBOutlet var mobileTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var toolBarBoneButton: UIBarButtonItem!
    
    @IBOutlet var toolBarCancelButton: UIBarButtonItem!
    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet var passwordTextField: UITextField!
    
    override func initView() {
       super.initView()
       initialisation()
        localisation()
    }
    
    func initialisation(){
        self.title = "Qoot".localiz()
        mobileTextField.inputAccessoryView = toolBar
        addingLeftBarButton()
    }
    
    func localisation(){
        mobileTextField.placeholder = "MobNoPlaceholder".localiz()
        passwordTextField.placeholder = "PwdPlaceholder".localiz()
        loginButton.setTitle("LOGIN".localiz(), for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func tapAction(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func loginButtonAction(_ sender: Any) {
//        if isValidInputs(){
//           callingLoginApi()
//        }
        UserDefaults.standard.set(true, forKey: Constant.VariableNames.isLoogedIn)
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func toolBarDoneButtonAction(_ sender: Any) {
        passwordTextField.becomeFirstResponder()
    }
    
    @IBAction func toolBarCancelButtonAction(_ sender: Any) {
        view.endEditing(true)
    }
    
    //MARK: UITextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
        return true
    }
    
    //MARK: Validation
    
    func isValidInputs()->Bool{
        var valid = true
        var message = ""
        if (mobileTextField.text?.isEmpty)!{
            message = "FILLMANDATORYFIELDS".localiz()
            valid = false
        }
        else if (passwordTextField.text?.isEmpty)!{
            message = "FILLMANDATORYFIELDS".localiz()
            valid = false
        }
        if (!valid){
            CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: message, parentController: self)
        }
        return valid
    }
    
    //MARK: Login Api
    
    func  callingLoginApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingLogInApi(with: getLoginRequestBody(), success: {
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
    
    func getLoginRequestBody()->String{
        var dict:[String:String] = [String:String]()
        if let phone = self.mobileTextField.text {
            dict.updateValue(phone, forKey: "username")
        }
        if let password = self.passwordTextField.text {
            dict.updateValue(password, forKey: "password")
        }
        return CCUtility.getJSONfrom(dictionary: dict)
    }
}
