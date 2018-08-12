//
//  LoginViewController.swift
//  Qoot
//
//  Created by Vishnu KM on 12/08/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet var mobileTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var toolBarBoneButton: UIBarButtonItem!
    
    @IBOutlet var toolBarCancelButton: UIBarButtonItem!
    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileTextField.inputAccessoryView = toolBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func tapAction(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func loginButtonAction(_ sender: Any) {
        
    }
    @IBAction func toolBarDoneButtonAction(_ sender: Any) {
        passwordTextField.becomeFirstResponder()
    }
    
    @IBAction func toolBarCancelButtonAction(_ sender: Any) {
    }
    //MARK: UITextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
        return true
    }
}
