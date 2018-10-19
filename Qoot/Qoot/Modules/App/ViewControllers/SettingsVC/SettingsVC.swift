//
//  SettingsVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 9/26/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit
import CoreData


class SettingsVC: BaseViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var changePassword: UILabel!
    @IBOutlet weak var addressesTitle: UILabel!
    @IBOutlet weak var changeProfileTitle: UILabel!
    override func initView() {
        initialisation()
        localization()
    }
    
    func initialisation(){
        addingLeftBarButton()
    }
    
    func localization(){
        self.title = "Settings".localiz()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Actions
    
    override func leftNavButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Camera Actions
    
    @IBAction func imageClickAction(_ sender: Any) {
//        CameraHandler().checkCameraPermissionFromViewController(viewController: self) { (isSucess, imagePicker) in
//            imagePicker.delegate = self;
//        }
        
    }
    
    // MARK: - PickerDelegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
       
//        self.imageData = UIImagePNGRepresentation(selectedImage)!;
//        profileImage.image = selectedImage
        self.profileImageButton.setImage(selectedImage, for: .normal)
        
        // Dismiss the picker.
        
        dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }

}
