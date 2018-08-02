//
//  CCConstants.swift
//  CCLUB
//
//  Created by Albin Joseph on 2/7/18.
//  Copyright © 2018 Albin Joseph. All rights reserved.
//

import Foundation
import UIKit


struct Constant{
    static let AppName = "Qoot"
    struct Font{
        static let Regular = "Times New Roman"
    }
    struct Notifications{
        static let RootSettingNotification = "com.alwisal.initNotification"
        static let UserProfileNotification = "com.alwisal.userProfileNotification"
        static let PlayerArtistInfo = "com.alwisal.artistInfoNotification"
    }
    struct VariableNames {
        static let isLoogedIn = "isLoggedIn"
        static let userToken = "userToken"
        static let userName = "userName"
        static let userImage = "userImage"
        static let userId = "userId"
    }
    
    struct Colors {
        static let CommonMeroonColor = UIColor(red:0.64, green:0.10, blue:0.36, alpha:1.0) //a21a5c
        static let CommonGreenColor = UIColor(red:0.58, green:0.76, blue:0.12, alpha:1.0) //94c11e
        static let CommonRedColor = UIColor(red:1.00, green:0.00, blue:0.00, alpha:1.0) //fe0000
        static let CommonGreyColor = UIColor(red:0.72, green:0.71, blue:0.70, alpha:1.0) //b8b4b3
        static let CommonPinkColor = UIColor(red:0.91, green:0.80, blue:0.85, alpha:1.0) //e8ccda
        static let CommonBlackColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0) //333333
    }
    
    struct ErrorMessages {
        static let noNetworkMessage = "No Internet connection. Please check your connection settings and try again!"
        static let serverErrorMessamge = "Cannot connect to server, please try again."
    }
    
    struct ImageNames {
        static let placeholderImage = "placeholder"
        static let placeholderArtistInfoImage = "songDefaultImage"
        static let profilePlaceholderImage = "placeholder"
        struct tabImages{
            static let soundIcon = "soundIcon"
            static let muteIcon = "muteIcon"
            static let playIcon = "playIcon"
            static let pauseIcon = "pauseIcon"
        }
    }
    
    struct SegueIdentifiers {
        static let presenterToPresenterDetailSegue = "presenterToDetail"
        static let landingToNewsList = "landingToNewsList"
        static let landingToPresenterDetail = "landingToPrsenterDetails"
    }
    struct AppKeys {
        static let googleClientID = "338103195232-0l3102r119pifji42ge14km2qhm14teh.apps.googleusercontent.com"
        static let twitterConsumerKey = "x0oIx3qZN9PLTxfXxnxbjB7jA"
        static let twitterConsumerSecret = "NtKfWYpxSyqS2HMx1YBtLrOoAuRZZ4zswe8joewEmrupPPny8E"
        static let artistInfoKey = "665b8ff2830d494379dbce3fb3b218a9"
    }
    
    struct Messages {
        static let yesString = "YES"
        static let noString = "NO"
        static let okString = "Ok"
        static let cancelString = "Cancel"
        static let logInMessage = "Please sign in to use this feature"
        static let InfoNotAvaliable = "المعلومات غير متوفرة"
        static let logoutMessage = "Do you want to logout?"
        
    }
    static let AuthenticationToken = "53067a56941ff00369b726d450ef3bb9495c7224"
    
    static let audioStreamingUrlString = "http://uk7.internet-radio.com:8040"
    static let facebookLink = "https://www.facebook.com/radiomerge"
    static let twitterLink = "https://twitter.com/radiomerge"
    static let contactUsUrlString = "http://test.radiomerge.fm/contact-us?app=1"
    
    static let sharingUrlString = "http://alwisal.radio.net/"
}
