//
//  SettingsVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 9/26/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit
import CoreData
import Alamofire


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
        let addressListingVC = AddressListingVC.init(nibName: "AddressListingVC", bundle: nil)
        self.navigationController?.pushViewController(addressListingVC, animated: true)
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
                self.callingUploadApi(image: pickedImage)
            }
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func callingUploadApi(image:UIImage){
        
        var dict:[String:String] = [String:String]()
        dict.updateValue(Constant.ApiKey, forKey: "apikey")
        dict.updateValue(CCUtility.getCurrentLanguage(), forKey: "lang")
        if let user = User.getUser(){
            dict.updateValue("\(user.userId)", forKey: "CustomerId")
        }
        let imageData: Data = UIImagePNGRepresentation(image)!
        requestWith(endUrl: "https://qoot.online/ksa/test/Ios/Customer/UploadCustomerPhoto", imageData: imageData, parameters: dict, onCompletion: { (success) in
            print("Success")
        }) { (error) in
            print("Failure")
        }
    }
    
    
    func requestWith(endUrl: String, imageData: Data?, parameters: [String : Any], onCompletion: ((Bool) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        
        let url = "http://google.com" /* your API url */
        
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if let data = imageData{
                multipartFormData.append(data, withName: "image.png", fileName: "file ", mimeType: "image/png")
            }
            
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    
                    print("Response:\(response)")
//                    let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(response)
                    
                    print("Succesfully uploaded")
                    if let err = response.error{
                        print(err.localizedDescription)
                        onError?(err)
                        return
                    }
                    onCompletion?(true)
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                onError?(error)
            }
        }
    }
    
}

