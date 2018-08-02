//
//  CCConstants.swift
//  CCLUB
//
//  Created by Albin Joseph on 2/7/18.
//  Copyright © 2018 Albin Joseph. All rights reserved.
//

import Foundation
import UIKit

let APPNAME = "FETCH"

let USERNAMEVALIDATIONTEXTMESSAGE  = "Please enter your username"
let EMAILVALIDATIONTEXTMESSAGE  = "Please enter a valid Email address"
let PHONEVALIDATIONTEXTMESSAGE  = "Please enter valid phone number"
let CARDNOVALIDATION = "Please enter valid card number"
let CVVNOVALIDATION = "Please enter valid cvv"
let PHONEEMPTYVALIDATIONTEXTMESSAGE  = "Please enter your phone number"
let EMAILEMPTYTEXTMESSAGE  = "Please enter your Email address"
let EMPTYPASSWORD  = "Please enter your password"
let EMPTYCARDTYPE  = "Please select a card type"
let EMPTYPAYMENTMODE = "Please select payment mode"
let EMPTYCARDHOLDER = "Please enter card holder name"
let EMPTYCARDNO = "Please enter card number"
let EMPTYCVV = "Please enter cvv"
let ISLOGIN = "Please login to continue"
let LOGOUTWARNINGMESSAGE = "Are you sure you want to Log Out?"

let CURRENTPSWDVALIDATIONMSG = "Please enter your current password"
let NEWPSWDVALIDATIONMSG = "Please enter new password"
let PASSWORDMATCHVALIDATIONMSG = "Your New Password should not be same as current Password"
let ADDRESSVALIDATION = "Please enter your address"
let AREAVALIDATION = "Please select an area"
let PETVALIDATION = "Please select a pet category"
let DOBVALIDATION = "Please select your date of birth"

let NEWPSWDMATCHVALIDATIONMSG = "Your password and confirm password should be same"
let VALIDPASSWORDVALIDATIONMSG = "Your password should be at least 8 character long"
let CONFIRMPASSWORDVALIDATIONMSG = "Please enter confirm password"
let TERMSANDCONDITIONS = "Please accept the terms and conditions"
let EMPTYCOUPON = "Please enter coupon code"

let SIGNUPSUCCESS = "Congrats! you have successfully registered"

let IS_IPHONE_4_OR_LESS  = UIScreen.main.bounds.height < 568.0
let IS_IPHONE_5SE        = UIScreen.main.bounds.height  == 568.0
let IS_IPHONE_7          = UIScreen.main.bounds.height  == 667.0
let IS_IPHONE_7P         = UIScreen.main.bounds.height  == 736.0
let IS_IPHONE_X          = UIScreen.main.bounds.height  == 812.0
let IS_IPAD              = UIScreen.main.bounds.height  == 1024.0


//MARK :- Color Codes
let BACKGROUND_COLOR = UIColor.init(red: 229.0/255, green: 236/255, blue: 247.0/255, alpha: 1.0)
let ACTIVE_BLUE = UIColor.init(red: 9/255, green: 52/255, blue: 122/255, alpha: 1.0)
let INACTIVE_BLUE = UIColor.init(red: 100/255, green: 124/255, blue: 157/255, alpha: 1.0)
let APP_YELLOW_COLOR = UIColor(red:1.00, green:0.82, blue:0.00, alpha:1.0) //FFD200
let APP_GREY_COLOR = UIColor(red:0.56, green:0.56, blue:0.56, alpha:1.0) //8E8E8E

//MARK :- Fonts
let SWISSRA_BLACK = "SwissraCondensed-Black"
let SWISSRA_BOLD = "SwissraCondensed-Bold"
let SWISSRA_HEAVY = "SwissraCondensed-Heavy"
let SWISSRA_LIGHT = "SwissraCondensed-Light"
let SWISSRA_MEDIUM = "SwissraCondensed-Medium"
let SWISSRA_NORMAL = "SwissraCondensed-Normal"
let SWISSRA_THIN = "SwissraCondensed-Thin"
let SWISSRA_ULTRA_LIGHT = "SwissraCondensed-UltraLight"
let TOOLBARATTR = [
    NSAttributedStringKey.font: UIFont(name: SWISSRA_NORMAL, size: 20)!
]
let ALERTMSGATTR = [
    NSAttributedStringKey.font: UIFont(name: SWISSRA_NORMAL, size: 14)!
]
let ALERTBUTTONATTR = [
    NSAttributedStringKey.font: UIFont(name: SWISSRA_BOLD, size: 16)!
]

//MARK:- Entities
let EN_CCTOKENS = "CCAppToken"
let EN_CCNOTIFSETNGS = "KPNotificationSettings"
let EN_CCUSERMANAGEMENT = "CCUserManagement"

//MARK:- Status Codes
let SESSION_EXPIRED = 403
let SUCCESS = 200

//MARK:- Date Format

let YYYY_MM_DD = "YYYY-MM-DD"
let DD_MMM_YYYY = "DD MMM, YYYY"

//MARK:- User Defaults

let LOGINSUCCESS = "loginSuccess"
let ISSECONDLOGIN = "isSecondLogIn"


struct ErrorMessages{
    static let noNetworkMessage = "NONET".localiz()
    static let serverErrorMessamge = "UNABLECONNECT".localiz()
}

struct ImageNames {
    static let placeholderImageName = "placeholderImage"
}

struct WebViewUrls {
    static let disclaimerUrlEnglish = "http://34.214.67.129/kpFetch/index.php/documents/disclaimer_en"
    static let disclaimerUrlArabic = "http://34.214.67.129/kpFetch/index.php/documents/disclaimer_ar"
    static let termsAndConditionsUrlEnglish = "http://34.214.67.129/kpFetch/index.php/documents/termsConditions_en"
    static let termsAndConditionsUrlArabic = "http://34.214.67.129/kpFetch/index.php/documents/termsConditions_ar"
}
