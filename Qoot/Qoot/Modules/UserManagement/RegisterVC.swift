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
        sender.isSelected = !sender.isSelected
        femaleButton.isSelected = false
    }
    
    @IBAction func femaleButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        maleButton.isSelected = false
    }
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
