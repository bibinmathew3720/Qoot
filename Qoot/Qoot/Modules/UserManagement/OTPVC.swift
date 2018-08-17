//
//  OTPVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 8/17/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class OTPVC: BaseViewController,UITextFieldDelegate {
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var otpTF: UITextField!
    @IBOutlet weak var smsTitleLabel: UILabel!
    @IBOutlet weak var resendOTPButton: UIButton!
    @IBOutlet weak var verifyOTPButton: UIButton!
    
    var mobNoString:String?
    override func initView() {
        initialisation()
    }
    
    func initialisation(){
        self.title = Constant.AppName
        self.navigationController?.navigationItem.leftBarButtonItem = nil
        otpTF.becomeFirstResponder()
        localisation()
    }
    
    func localisation(){
        if let mobNo = mobNoString{
            headingLabel.text = "CONFIRMCODEMGE".localiz() + " \(mobNo)\n" + "ENTERCODEBELOW".localiz()
        }
        smsTitleLabel.text = "DIDNTRECEIVESMS".localiz()
        resendOTPButton.setTitle("RESENDOTP".localiz(), for: UIControlState.normal)
        verifyOTPButton.setTitle("VERIFYOTP".localiz(), for: UIControlState.normal)
    }

    @IBAction func resendOTPButtonAction(_ sender: UIButton) {
    }
    @IBAction func verifyOTPButtonAction(_ sender: UIButton) {
        if isValidInputs(){
            
        }
    }
    
    @IBAction func tapgestureAction(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        if (otpTF.text?.isEmpty)!{
            message = "INVALIDOTP".localiz()
            valid = false
        }
        if (!valid){
            CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: message, parentController: self)
        }
        return valid
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
