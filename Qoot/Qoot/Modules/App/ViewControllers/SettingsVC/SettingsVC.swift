//
//  SettingsVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 9/26/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit
import CoreData


class SettingsVC: BaseViewController {
    
    @IBOutlet weak var changeProfileTitle: UILabel!
    @IBOutlet weak var myAddressesTitle: UILabel!
    @IBOutlet weak var changePassword: UILabel!
    @IBOutlet weak var oldPwdtF: UITextField!
    @IBOutlet weak var newPwdTF: UITextField!
    @IBOutlet weak var confirmPwdTF: UITextField!
    @IBOutlet weak var updatePwdButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var selProfImage:UIImage?
    
    
    override func initView() {
        initialisation()
        localization()
    }
    
    func initialisation(){
        addingLeftBarButton()
    }
    
    func localization(){
        self.title = "Settings".localiz()
        changeProfileTitle.text = "ChangeProfilePicture".localiz()
        myAddressesTitle.text = "MyAddresses".localiz()
        changePassword.text = "ChangePassword".localiz()
        oldPwdtF.placeholder = "OldPassword".localiz()
        newPwdTF.placeholder = "NewPassword".localiz()
        confirmPwdTF.placeholder = "ConfirmNewPassword".localiz()
        updatePwdButton.setTitle("UpdatePassword".localiz(), for: UIControlState.normal)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Actions
    
    override func leftNavButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func myAddressesButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func updatePasswordButtonAction(_ sender: UIButton) {
        if isValidChangePasswordRequest(){
            callingChangePasswordApi()
        }
    }
    
    func isValidChangePasswordRequest()->Bool{
        var isValid = true
        var message = ""
        if (newPwdTF.text?.isEmpty)!{
            message = "PASSWORDATLEASTSIXDIGITS".localiz()
            isValid = false
        }
        else if ((newPwdTF.text?.count)! < 6){
            message = "PASSWORDATLEASTSIXDIGITS".localiz()
            isValid = false
        }
        else if newPwdTF.text != confirmPwdTF.text{
            message = "NEWPASSWORDDOESNTMATCHES".localiz()
            isValid = false
        }
        if (!isValid){
            CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: message, parentController: self)
        }
        return isValid
    }
    
    //MARK: Change Password Api
    
    func  callingChangePasswordApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingChangePasswordApi(with: getChangePwdRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
           
            if let model = model as? ChangePasswordResponseModel{
                if model.statusCode == 1{
                    CCUtility.showDefaultAlertwithCompletionHandler(_title: Constant.AppName, _message: "PasswordChanged".localiz(), parentController: self, completion: { (okSuccess) in
                        self.dismiss(animated: true, completion: nil)
                    })
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
    
    func getChangePwdRequestBody()->String{
        var dataString:String = ""
        if let oldPwd = self.oldPwdtF.text {
            let oldPwdString:String = "OldPWD=\(oldPwd.urlEncode())"
            dataString = dataString + oldPwdString + "&"
        }
        if let newPwd = self.newPwdTF.text {
            let newPwdString:String = "NewPWD=\(newPwd.urlEncode())"
            dataString = dataString + newPwdString + "&"
        }
        if let user = User.getUser(){
            let userIdString:String = "CustomerId=\(user.userId)"
            dataString = dataString + userIdString
        }
        return dataString
    }
    
    // MARK: - Camera Actions
    
    @IBAction func imageClickAction(_ sender: Any) {
        addingImagePickerController(sourceType: .photoLibrary)
        
    }
    
    func addingImagePickerController(sourceType:UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType;
        present(imagePicker, animated: true, completion: nil)
    }
}

extension SettingsVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true) {
            if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                self.selProfImage = pickedImage
                self.profileImageView.image = pickedImage
            }
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

