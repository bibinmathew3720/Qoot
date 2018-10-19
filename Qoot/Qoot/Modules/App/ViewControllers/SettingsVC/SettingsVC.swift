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

