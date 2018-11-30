//
//  DashboardVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 8/2/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import FBSDKCoreKit

class DashboardVC: BaseViewController,GIDSignInUIDelegate,GIDSignInDelegate {
    @IBOutlet weak var loginViaFBButton: UIButton!
    @IBOutlet weak var loginViaGoogleButton: UIButton!
    @IBOutlet weak var loginViaQootButton: UIButton!
    @IBOutlet weak var registerLabel: UILabel!
    
    override func initView() {
        initialisation()
        localisation()
        addRegisterLabel()
        addingLeftBarButton()
    }
    
    func initialisation(){
        self.title = "Qoot".localiz()
    }
    
    func localisation(){
        loginViaFBButton.setTitle("LOGINVIAFACEBOOK".localiz(), for: UIControlState.normal)
        loginViaGoogleButton.setTitle("LOGINVIAGOOGLE".localiz(), for: UIControlState.normal)
        loginViaQootButton.setTitle("LOGINVIAQOOT".localiz(), for: UIControlState.normal)
    }
    
    func addRegisterLabel(){
        let string1 = "DONTHAVEANACCOUNT".localiz()
        let string2 = "REGISTER".localiz()
        let myString:String = string1 + " " + string2
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font:UIFont(name: Constant.Font.Regular, size: 19)!])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: Constant.Colors.CommonRedColor, range: NSRange(location:myString.count - string2.count,length:string2.count))
        registerLabel.attributedText = myMutableString
        registerLabel.isUserInteractionEnabled = true
        registerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapOnGuestLabel(_:))))
    }
    
    //Tap Gesture Action
    
    @objc func handleTapOnGuestLabel(_ recognizer: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: Constant.SegueIdentifiers.dashBoardToRegister, sender: nil)
    }
    
    //Button Actions
    
    @IBAction func facebookButtonAction(_ sender: UIButton) {
        let login: FBSDKLoginManager = FBSDKLoginManager()
        ApplicationController.applicationController.loginType = .faceBook
        MBProgressHUD.showAdded(to: self.view, animated: true)
        login.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            print(result)
            //self.flowerUserProfile()
        }
    }
    
    @IBAction func googlePlusButtonAction(_ sender: UIButton) {
        ApplicationController.applicationController.loginType = .googlePlus
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func logInButtonAction(_ sender: UIButton) {
        let loginVC = LoginViewController.init(nibName: "LoginViewController", bundle: nil)
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    override func leftNavButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            var googleDetails = [String:AnyObject]()
            googleDetails["id"] = user.authentication.clientID as AnyObject
            googleDetails["email"] = user.profile.email as AnyObject
            googleDetails["name"] = user.profile.name as AnyObject
            //self.socialMediaResponse = FlowerSocialMediaResponseModel.init(dict: googleDetails)
            //self.callingSocialLoginApi()
        }
    }
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
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
