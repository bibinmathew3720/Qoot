//
//  User.swift
//  Fetch
//
//  Created by Bibin Mathew on 6/27/18.
//  Copyright © 2018 CL. All rights reserved.
//

import UIKit
import CoreData

class User: NSManagedObject {
    
    static func saveUserData(userData:QootLogInResponseModel){
        if let user = User.getUser() {
            updateUserDB(user: user, userData: userData)
        } else {
         let user = CoreDataHandler.sharedInstance.newEntityForName(entityName: "User") as? User
//            user?.refreshToken = userData.refreshToken
//            user?.sessionToken = userData.sessionToken
            updateUserDB(user:user!, userData: userData)
        }
        
    }
    
    class func updateUserDB(user:User,userData:QootLogInResponseModel) {
        user.city = userData.customer_city
        user.customerLanguage = userData.customer_language
        user.customerPhoto = userData.customer_photo
        user.dob = userData.customer_dob
        user.email = userData.userEmail
        user.gender = userData.customer_gender
        user.joinDate = userData.customer_join_date
        user.lastLogin = userData.customer_last_login
        user.loginStatus = userData.login_status
        user.membershipType = userData.membership_type
        user.message = userData.statusMessage
        user.mobileNumber = userData.mobile_number
        user.name = userData.userName
        user.password = userData.password
        user.registerID = Int16(userData.registration_id)
        user.registerType = userData.registration_type
        //user.urlStatus = userData.url_status
        user.userId = Int16(userData.userId)
        CoreDataHandler.sharedInstance.saveContext()
    }
    
    class func getUser() -> User? {
        let detailsArrayPost:NSArray = CoreDataHandler.sharedInstance.getAllDatas(entity: "User") as NSArray
        if (detailsArrayPost.count != 0) {
            return detailsArrayPost.object(at: 0) as? User
        }
        return nil
    }
    
    class func updateProfileImage(updateProfileImageResponse:UploadProfileImageResponse) {
        if let user = User.getUser() {
            user.customerPhoto = updateProfileImageResponse.customer_photo
            CoreDataHandler.sharedInstance.saveContext()
        }
        
    }
    
    class func deleteUser() {
        CoreDataHandler.sharedInstance.deleteAllData(name: "User")
        CoreDataHandler.sharedInstance.saveContext()
    }
}
