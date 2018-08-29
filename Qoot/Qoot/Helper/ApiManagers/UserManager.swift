//
//  UserManager.swift
//  Fetch
//
//  Created by Bibin Mathew on 6/25/18.
//  Copyright © 2018 CL. All rights reserved.
//

import UIKit

class UserManager: CLBaseService {
    
    //MARK : Sign Up Api
    
    func callingSignUpApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForRegister(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getRegisterResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForRegister(with body:String)->CLNetworkModel{
        let registerRequestModel = CLNetworkModel.init(url: BASE_URL+REGISTER_URL, requestMethod_: "POST")
        registerRequestModel.requestBody = body
        return registerRequestModel
    }
    
    func getRegisterResponseModel(dict:[String : Any?]) -> Any? {
        let loginReponseModel = QootLogInResponseModel.init(dict:dict)
        return loginReponseModel
    }
    
    //MARK : City Name Api
    
    func callingCityNameApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForCityNames(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveArrayResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getCityNamesResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForCityNames(with body:String)->CLNetworkModel{
        let registerRequestModel = CLNetworkModel.init(url: BASE_URL+GETCITYNAMES_URL, requestMethod_: "POST")
        registerRequestModel.requestBody = body
        return registerRequestModel
    }
    
    func getCityNamesResponseModel(dict:NSArray) -> Any? {
        let cityNamesResponseModel = QootCityNamesResponseModel.init(arr:dict)
        return cityNamesResponseModel
    }
    
    //MARK : MealType Api
    
    func callingViewMealTypeApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForViewMealType(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveArrayResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getViewMealTypeResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForViewMealType(with body:String)->CLNetworkModel{
        let registerRequestModel = CLNetworkModel.init(url: BASE_URL+VIEWMEALTYPE_URL, requestMethod_: "POST")
        registerRequestModel.requestBody = body
        return registerRequestModel
    }
    
    func getViewMealTypeResponseModel(dict:NSArray) -> Any? {
        let mealTypeReponseModel = QootMealTypeResponseModel.init(arr:dict)
        return mealTypeReponseModel
    }
    
    //MARK : ViewCuisines Api
    
    func callingViewCuisinesApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForViewCuisines(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveArrayResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getViewCuisinesResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForViewCuisines(with body:String)->CLNetworkModel{
        let registerRequestModel = CLNetworkModel.init(url: BASE_URL+ViewCuisines_URL, requestMethod_: "POST")
        registerRequestModel.requestBody = body
        return registerRequestModel
    }
    
    func getViewCuisinesResponseModel(dict:NSArray) -> Any? {
        let viewCuisinesResponseModel = ViewCuisinesResponseModel.init(arr:dict)
        return viewCuisinesResponseModel
    }
    
    //MARK : Kitchens Api
    
    func callingKitchensApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForKitchens(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveArrayResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getKitchensResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForKitchens(with body:String)->CLNetworkModel{
        let registerRequestModel = CLNetworkModel.init(url: BASE_URL+ViewKitchens_URL, requestMethod_: "POST")
        registerRequestModel.requestBody = body
        return registerRequestModel
    }
    
    func getKitchensResponseModel(dict:NSArray) -> Any? {
        let kitchensResponseModel = KitchensResponseModel.init(arr:dict)
        return kitchensResponseModel
    }
    
  
    //MARK : Log In Api
    
    func callingLogInApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForLogIn(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getLogInResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForLogIn(with body:String)->CLNetworkModel{
        let loginRequestModel = CLNetworkModel.init(url: BASE_URL+LOGIN_URL, requestMethod_: "POST")
        loginRequestModel.requestBody = body
        return loginRequestModel
    }
    
    func getLogInResponseModel(dict:[String : Any?]) -> Any? {
        let logInReponseModel = QootLogInResponseModel.init(dict:dict)
        return logInReponseModel
    }
    
    //MARK : Get Offer Api
    
    func callingOfferDishesApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelOfferDishes(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveArrayResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getOfferDishesResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelOfferDishes(with body:String)->CLNetworkModel{
        let registerRequestModel = CLNetworkModel.init(url: BASE_URL+OfferDishes_URL, requestMethod_: "POST")
        registerRequestModel.requestBody = body
        return registerRequestModel
    }
    
    func getOfferDishesResponseModel(dict:NSArray) -> Any? {
        let offerDishesResponseModel = OfferDishesResponseModel.init(arr:dict)
        return offerDishesResponseModel
    }
    
    //MARK : Get Ready Now Dishes Api
    
    func callingReadyNowDishesApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelReadyNowDishes(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveArrayResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.readyNowDishesResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelReadyNowDishes(with body:String)->CLNetworkModel{
        let registerRequestModel = CLNetworkModel.init(url: BASE_URL+ReadyNowDishes_URL, requestMethod_: "POST")
        registerRequestModel.requestBody = body
        return registerRequestModel
    }
    
    func readyNowDishesResponseModel(dict:NSArray) -> Any? {
        let readyNowDishesResponseModel = ReadyNowDishesResponseModel.init(arr:dict)
        return readyNowDishesResponseModel
    }
    
    //Get Dish Details Api
    
    func callingGetDishDetailsApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForGetDishDetails(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getDishDetailsResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForGetDishDetails(with body:String)->CLNetworkModel{
        let dishDetailsRequestModel = CLNetworkModel.init(url: BASE_URL+DishDetails_URL, requestMethod_: "POST")
        dishDetailsRequestModel.requestBody = body
        return dishDetailsRequestModel
    }
    
    func getDishDetailsResponseModel(dict:[String : Any?]) -> Any? {
        let dishDetailsReponseModel = Dishes.init(dict:dict)
        return dishDetailsReponseModel
    }
    
    //Get Kitchen Details Api
    
    func callingGetKitchenDetailsApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForGetKitchenDetails(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getKitchenDetailsResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForGetKitchenDetails(with body:String)->CLNetworkModel{
        let kitchenDetailsRequestModel = CLNetworkModel.init(url: BASE_URL+KitchenDetails_URL, requestMethod_: "POST")
        kitchenDetailsRequestModel.requestBody = body
        return kitchenDetailsRequestModel
    }
    
    func getKitchenDetailsResponseModel(dict:[String : Any?]) -> Any? {
        let kitchenDetailsReponseModel = ViewKitchens.init(dict:dict)
        return kitchenDetailsReponseModel
    }
    
    //MARK : Log Out Api
    
    func callingLogOutApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForLogOut(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getLogOutResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForLogOut(with body:String)->CLNetworkModel{
        let logOutRequestModel = CLNetworkModel.init(url: BASE_URL+LOGOUT_URL, requestMethod_: "POST")
        logOutRequestModel.requestBody = body
        return logOutRequestModel
    }
    
    func getLogOutResponseModel(dict:[String : Any?]) -> Any? {
        let logOutReponseModel = QootLogInResponseModel.init(dict:dict)
        return logOutReponseModel
    }
    //MARK : Edit Profile Api
    
    func callingEditProfileApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForEditProfile(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getEditProfileResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForEditProfile(with body:String)->CLNetworkModel{
        let editProfileRequestModel = CLNetworkModel.init(url: BASE_URL+EDIT_PROFILE_URL, requestMethod_: "POST")
        editProfileRequestModel.requestBody = body
        return editProfileRequestModel
    }
    
    func getEditProfileResponseModel(dict:[String : Any?]) -> Any? {
        let editProfileRequestModel = QootLogInResponseModel.init(dict:dict)
        return editProfileRequestModel
    }
    
    //MARK: Get All Locations
    
    func callingGetAllLocationsApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForLocations(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getLocationsResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForLocations(with body:String)->CLNetworkModel{
        let locationRequestModel = CLNetworkModel.init(url: BASE_URL+GET_LOCATIONS_URL, requestMethod_: "GET")
        locationRequestModel.requestBody = body
        return locationRequestModel
    }
    
    func getLocationsResponseModel(dict:[String : Any?]) -> Any? {
        let locationReponseModel = FetchLocationsResponseModel.init(dict:dict)
        return locationReponseModel
    }
    
    //MARK: Get All Categories
    
    func callingGetAllCategoriesApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForCategories(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getCategoriesResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForCategories(with body:String)->CLNetworkModel{
        let categoriesRequestModel = CLNetworkModel.init(url: BASE_URL+GET_CATEGORIES_URL, requestMethod_: "POST")
        categoriesRequestModel.requestBody = body
        return categoriesRequestModel
    }
    
    func getCategoriesResponseModel(dict:[String : Any?]) -> Any? {
        let catgoeyReponseModel = FetchCategoriesResponseModel.init(dict:dict)
        return catgoeyReponseModel
    }
    func getProductResponseModel(dict:[String : Any?]) -> Any? {
        let productResponseModel = FetchProductTypeResponseModel.init(dict:dict)
        return productResponseModel
    }
    
    //MARK: ForgotPassword Api
    
    func callingForgotPaswordApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForForgotPassword(with: body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getForgotPasswordResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForForgotPassword(with body:String)->CLNetworkModel{
        let forgotPasswordRequestModel = CLNetworkModel.init(url: BASE_URL+FORGOT_PASS_URL, requestMethod_: "POST")
        forgotPasswordRequestModel.requestBody = body
        return forgotPasswordRequestModel
    }
    
    func getForgotPasswordResponseModel(dict:[String : Any?]) -> Any? {
        let forgotPasswordRequestModel = FetchForgotPasswordResponseModel.init(dict:dict)
        return forgotPasswordRequestModel
    }
    
    //MARK: ChangePassword Api
    
    func callingChangePasswordApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForChangePassword(with: body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getchangetPasswordResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForChangePassword(with body:String)->CLNetworkModel{
        let changePasswordRequestModel = CLNetworkModel.init(url: BASE_URL+CHANGE_PASS_URL, requestMethod_: "POST")
        changePasswordRequestModel.requestBody = body
        return changePasswordRequestModel
    }
    
    func getchangetPasswordResponseModel(dict:[String : Any?]) -> Any? {
        let changePasswordRequestModel = FetchForgotPasswordResponseModel.init(dict:dict)
        return changePasswordRequestModel
    }
    
    //MARK: Get Notifications Api
    
    func callingGetNotificationsApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForGetNotifications(with: body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getNotificationsResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForGetNotifications(with body:String)->CLNetworkModel{
        let getNotificationsRequestModel = CLNetworkModel.init(url: BASE_URL+GET_NOTIFICATIONS, requestMethod_: "POST")
        getNotificationsRequestModel.requestBody = body
        return getNotificationsRequestModel
    }
    
    func getNotificationsResponseModel(dict:[String : Any?]) -> Any? {
        let getNotificationsRequestModel = FetchGetNotificationsResponseModel.init(dict:dict)
        return getNotificationsRequestModel
    }
    
    
    //MARK: Get Notifications History Api
    
    func callingGetNotificationHistoryApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForGetNotificationsHistory(with: body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getNotificationsHistoryResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForGetNotificationsHistory(with body:String)->CLNetworkModel{
        let getNotificationsRequestModel = CLNetworkModel.init(url: BASE_URL+GET_NOTIFICATIONS_HISTORY, requestMethod_: "POST")
        getNotificationsRequestModel.requestBody = body
        return getNotificationsRequestModel
    }
    
    func getNotificationsHistoryResponseModel(dict:[String : Any?]) -> Any? {
        let getNotificationsRequestModel = FetchNotificationsHistoryResponseModel.init(dict:dict)
        return getNotificationsRequestModel
    }
    
    //MARK: Get Notifications Remove Api
    
    func callingNotificationRemoveApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForGetNotificationsRemove(with: body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getNotificationsRemoveResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForGetNotificationsRemove(with body:String)->CLNetworkModel{
        let getNotificationsRequestModel = CLNetworkModel.init(url: BASE_URL+REMOVE_NOTIFICATIONS, requestMethod_: "POST")
        getNotificationsRequestModel.requestBody = body
        return getNotificationsRequestModel
    }
    
    func getNotificationsRemoveResponseModel(dict:[String : Any?]) -> Any? {
        let getNotificationsRequestModel = FetchNotificationsHistoryResponseModel.init(dict:dict)
        return getNotificationsRequestModel
    }
    
    //MARK: Change Notifications Api
    
    func callingChangeNotificationsApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForChangeNotifications(with: body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.changeNotificationsResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForChangeNotifications(with body:String)->CLNetworkModel{
        let changeNotificationsRequestModel = CLNetworkModel.init(url: BASE_URL+CHANGE_NOTIFICATIONS, requestMethod_: "POST")
        changeNotificationsRequestModel.requestBody = body
        return changeNotificationsRequestModel
    }
    
    func changeNotificationsResponseModel(dict:[String : Any?]) -> Any? {
        let changeNotificationsRequestModel = FetchChangeNotificationsResponseModel.init(dict:dict)
        return changeNotificationsRequestModel
    }
    
    //MARK: Feedback Api
    
    func callingFeedbackApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForFeedback(with: body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.feedbackResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForFeedback(with body:String)->CLNetworkModel{
        let feedbackRequestModel = CLNetworkModel.init(url: BASE_URL+ADD_FEEDBACK_URL, requestMethod_: "POST")
        feedbackRequestModel.requestBody = body
        return feedbackRequestModel
    }
    
    func feedbackResponseModel(dict:[String : Any?]) -> Any? {
        let feedbackResponseModel = FetchFeedbackResponseModel.init(dict:dict)
        return feedbackResponseModel
    }
    
    //MARK: Get All Categories Subcategories Api
    
    func callingGetAllCategoriesSubcategoriesApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForCatSubcategories(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getCategoriesResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForCatSubcategories(with body:String)->CLNetworkModel{
        let categoriesRequestModel = CLNetworkModel.init(url: BASE_URL+GET_CAT_SUBCAT_URL, requestMethod_: "POST")
        categoriesRequestModel.requestBody = body
        return categoriesRequestModel
    }
    
    
    
    //MARK: Get All Types
    
    func callingGetAllTypesApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForAllTypes(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getProductResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForAllTypes(with body:String)->CLNetworkModel{
        let categoriesRequestModel = CLNetworkModel.init(url: BASE_URL+GET_CAT_TYPES, requestMethod_: "POST")
        categoriesRequestModel.requestBody = body
        return categoriesRequestModel
    }
    //MARK: Contact Us Api
    
    func callingContactUsApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForContactUs(with: body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.changeContactUsResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForContactUs(with body:String)->CLNetworkModel{
        let contactUsRequestModel = CLNetworkModel.init(url: BASE_URL+CONTACT_US_URL, requestMethod_: "POST")
        contactUsRequestModel.requestBody = body
        return contactUsRequestModel
    }
    
    func changeContactUsResponseModel(dict:[String : Any?]) -> Any? {
        let contactUsReponseModel = FetchContactUsResponseModel.init(dict:dict)
        return contactUsReponseModel
    }
}



class FetchRegister: NSObject {
    var username = ""
    var emailid: String = ""
    var password:String = ""
    var mobile:String = ""
    var dob:String = ""
    var address1:String = ""
    var address2:String = ""
    var languageId:NSNumber = 0
    var platform:NSNumber = 1
    var categories = [NSNumber]()
    var locationId:NSNumber = 0
    
    func getRequestBody()->String{
        var dict:[String:AnyObject] = [String:AnyObject]()
        dict.updateValue(emailid as AnyObject, forKey: "u_email")
        dict.updateValue(password as AnyObject, forKey: "u_password")
        dict.updateValue(mobile as AnyObject, forKey: "u_mobile")
        dict.updateValue(dob as AnyObject, forKey: "u_dob")
        dict.updateValue(address1 as AnyObject, forKey: "u_address1")
        dict.updateValue(address2 as AnyObject, forKey: "u_address2")
        if let deviceTok = ApplicationController.deviceToken{
            dict.updateValue(deviceTok as AnyObject, forKey: "device_token")
        } else {
            dict.updateValue("fgdgdgd5667575" as AnyObject, forKey: "device_token")
        }
        dict.updateValue(languageId, forKey: "language_id")
        dict.updateValue(platform, forKey: "u_platform")
        dict.updateValue(categories as AnyObject, forKey: "category_id")
        dict.updateValue(locationId, forKey: "location_id")
        return CCUtility.getJSONfrom(dictionary: dict)
    }
}

class QootRegisterResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        if let value = dict["errorMsg"] as? String{
            errorMessage = value
        }
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
        if let value = dict["session_token"] as? String{
           
        }
        if let value = dict["refresh_token"] as? String{
            
        }
        
    }
}

class FetchLogIn: NSObject {
    var emailid: String = ""
    var password:String = ""
    var platform:NSNumber = 1
    
    func getRequestBody()->String{
        var dict:[String:AnyObject] = [String:AnyObject]()
        dict.updateValue(emailid as AnyObject, forKey: "u_email")
        dict.updateValue(password as AnyObject, forKey: "u_password")
        if let deviceTok = ApplicationController.deviceToken{
           dict.updateValue(deviceTok as AnyObject, forKey: "device_token")
        } else {
            dict.updateValue("fgdgdgd5667575" as AnyObject, forKey: "device_token")
        }
        dict.updateValue(platform, forKey: "u_platform")
        return CCUtility.getJSONfrom(dictionary: dict)
    }
}


class QootLogInResponseModel : NSObject{
    
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    var sessionToken:String = ""
    var refreshToken:String = ""
    
    var userId:Int = 0
    var catId:Int = 0
    var locId:Int = 0
    var languageId:Int = 0
    var notSettings:Bool = true
    var userName:String = ""
    var userEmail:String = ""
    var userMobile:Int = 0
    var userDOB:String = ""
    var userArea:String = ""
    var userPet:String = ""
    var userAddress1:String = ""
    var userAddress2:String = ""
    var userProfileImageUrl:String = ""
    var userCategories = [UserCategories]()
    init(dict:[String:Any?]) {
        if let value = dict["message"] as? String{
            statusMessage = value
        }
        if let value = dict["errorMsg"] as? String{
            errorMessage = value
        }
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
        
        if let value = dict["session_token"] as? String{
            sessionToken = value
        }
        if let value = dict["refresh_token"] as? String{
            refreshToken = value
        }
        if let user = dict["user"] as? AnyObject{
            if let value = user["user_id"] as? Int{
                userId = value
            }
            if let value = user["categories"] as? NSArray{
                
                    for item in value{
                        if let it = item as? [String : Any?]{
                            userCategories.append(UserCategories.init(dict: it ))
                        }
                    }
            }
            if let value = user["location_id"] as? Int{
                locId = value
            }
            if let value = user["language_id"] as? Int{
                languageId = value
            }
            if let value = user["u_Name"] as? String{
                userName = value
            }
            if let value = user["u_address1"] as? String{
                userAddress1 = value
            }
            if let value = user["u_address2"] as? String{
                userAddress2 = value
            }
            if let value = user["u_dob"] as? String{
                userDOB = value
            }
            if let value = user["u_email"] as? String{
                userEmail = value
            }
            if let value = user["u_mobile"] as? NSNumber{
                userMobile = Int(truncating: value)
            }
            if let value = user["u_profilePicURL"] as? String{
                userProfileImageUrl = value
            }
            if let value = user["location_name"] as? String{
                userArea = value
            }
            if let value = user["category_name"] as? String{
                userPet = value
            }
        }
}
}

class UserCategories : NSObject{
    var catId:Int = 0
    var catName:String = ""
    
    init(dict:[String:Any?]) {
        if let value = dict["category_id"] as? Int{
            catId = value
        }
        if let value = dict["category_name"] as? String{
            catName = value
        }
    }
}

class QootCityNamesResponseModel : NSObject{
    var cityNames = [CityName]()
    init(arr:(NSArray)) {
        for item in arr{
            if let it = item as? [String : Any?]{
                cityNames.append(CityName.init(dict: it ))
            }
        }
    }
}

class CityName : NSObject{
    var cityId:Int = 0
    var cityName:String = ""
    init(dict:[String:Any?]) {
        if let value = dict["city_id"] as? String{
            if let ctyId = Int(value){
               cityId = ctyId
            }
        }
        if let value = dict["city_name"] as? String{
            cityName = value
        }
    }
}


class QootMealTypeResponseModel : NSObject{
    var mealTypes = [MealTypes]()
    init(arr:(NSArray)) {
        for item in arr{
            if let it = item as? [String : Any?]{
                mealTypes.append(MealTypes.init(dict: it ))
            }
        }
    }
}

class MealTypes : NSObject{
    var catId:Int = 0
    var catName:String = ""
    var categoryIcon:String = ""
    var sort_col:Int = 0
    init(dict:[String:Any?]) {
        if let value = dict["category_id"] as? String{
            if let catID = Int(value){
                catId = catID
            }
        }
        if let value = dict["category_name"] as? String{
            catName = value
        }
        if let value = dict["category_icon"] as? String{
            categoryIcon = value
        }
        if let value = dict["sort_col"] as? Int{
            sort_col = value
        }
    }
}

class KitchensResponseModel : NSObject{
    var viewKitchens = [ViewKitchens]()
    init(arr:(NSArray)) {
        for item in arr{
            if let it = item as? [String : Any?]{
                viewKitchens.append(ViewKitchens.init(dict: it ))
            }
        }
    }
}

class ViewKitchens : NSObject{
    var KitchenId:Int = 0
    var KitchenName:String = ""
    var KitchenLogo:String = ""
    var KitchenDeliveryFee:Int = 0
    var CutomerRating:Int = 0
    var OpenStatus:Bool = false
    var AdminRating:Int = 0
    
    init(dict:[String:Any?]) {
//        if let value = dict["KitchenId"] as? String{
//            if let kitchenID = Int(value){
//                catId = kitchenID
//            }
//        }
        if let value = dict["KitchenId"] as? Int{
            KitchenId = value
        }
        if let value = dict["KitchenName"] as? String{
            KitchenName = value
        }
        if let value = dict["KitchenLogo"] as? String{
            KitchenLogo = value
        }
        if let value = dict["KitchenDeliveryFee"] as? String{
            if let deliveryFee = Int(value){
                KitchenDeliveryFee = deliveryFee
            }
        }
        if let value = dict["CutomerRating"] as? Int{
            CutomerRating = value
        }
        if let value = dict["OpenStatus"] as? Bool{
            OpenStatus = value
        }
        if let value = dict["AdminRating"] as? Int{
            AdminRating = value
        }
    }
}
class ViewCuisinesResponseModel : NSObject{
    var viewCuisines = [ViewCuisines]()
    init(arr:(NSArray)) {
        for item in arr{
            if let it = item as? [String : Any?]{
                viewCuisines.append(ViewCuisines.init(dict: it ))
            }
        }
    }
}

class ViewCuisines : NSObject{
    var catId:Int = 0
    var subCatName:String = ""
    var subCatId:Int = 0
    
    init(dict:[String:Any?]) {
        
        if let value = dict["category_id"] as? String{
            if let catID = Int(value){
                catId = catID
            }
        }
        if let value = dict["sub_category_name"] as? String{
            subCatName = value
        }
        if let value = dict["sub_category_id"] as? String{
            if let sub_catID = Int(value){
                subCatId = sub_catID
            }
        }
    }
}
class FetchLocationsResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    var locations = [FetchLocation]()
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
        if let value = dict["data"] as? NSArray{
            for item in value{
                locations.append(FetchLocation.init(dict: item as! [String : Any?]))
            }
        }
        
        
    }
}

class FetchForgotPasswordResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
    }
}

class FetchGetNotificationsResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    var notificationStatus:String = ""
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
        if let value = dict["notification_status"] as? String{
            notificationStatus = value
        }
    }
}

class FetchNotificationsHistoryResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    var total:Int = 0
    var data = [FetchNotificationData]()
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
        if let value = dict["total"] as? Int{
            total = value
        }
        if let value = dict["data"] as? NSArray{
            for item in value{
                data.append(FetchNotificationData.init(dict: item as! [String : Any?]))
            }
        }
    }
}

class FetchNotificationData : NSObject{
    var id:Int = 0
    var user_id:Int = 0
    var type_id:Int =  0
    var type:String = ""
    var msg_content:String = ""
    var status:String = ""
    var created_date:String = ""
    var updated_date:String = ""
    var img_url:String = ""

    init(dict:[String:Any?]) {
        if let value = dict["id"] as? Int{
            id = value
        }

        if let value = dict["user_id"] as? Int{
            user_id = value
        }
        if let value = dict["type_id"] as? Int{
            type_id = value
        }
        if let value = dict["type"] as? String{
            type = value
        }
        if let value = dict["msg_content"] as? String{
            msg_content = value
        }
        if let value = dict["status"] as? String{
            status = value
        }
        if let value = dict["created_at"] as? String{
            created_date = value
        }
        if let value = dict["updated_at"] as? String{
            updated_date = value
        }
        if let value = dict["img_url"] as? String{
            img_url = value
        }
    }
}

class FetchChangeNotificationsResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
    }
}

class FetchLocation : NSObject{
    var delivery_charge:Int = 0
    var delivery_time:String = ""
    var location_id:Int = 0
    var location_name:String = ""
    init(dict:[String:Any?]) {
        if let value = dict["delivery_charge"] as? Int{
            delivery_charge = value
        }
        if let value = dict["delivery_time"] as? String{
            delivery_time = value
        }
        if let value = dict["location_id"] as? Int{
            location_id = value
        }
        if let value = dict["location_name"] as? String{
            location_name = value
        }
    }
}
class FetchContactUsResponseModel: NSObject {
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
    }
}

class FetchContactUsRequestModel: NSObject {
    var email: String = ""
    var name:String = ""
    var message:String = ""
    func getRequestBody()->String{
        var dict:[String:AnyObject] = [String:AnyObject]()
        dict.updateValue(email as AnyObject, forKey: "u_email")
        dict.updateValue(name as AnyObject, forKey: "u_name")
        dict.updateValue(message as AnyObject, forKey: "u_message")
//        if let user = User.getUser() {
//            dict.updateValue(String(user.userId) as AnyObject , forKey: "user_id")
//        }
        let languageString = L102Language.currentAppleLanguage()
        var languageId:NSNumber = 1
        if (languageString == "ar"){
            languageId = 2
        }
        dict.updateValue(languageId.stringValue as AnyObject, forKey: "language_id")
        return CCUtility.getJSONfrom(dictionary: dict)
    }
}

class FetchCategoriesResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    var categories = [FetchCategory]()
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
        if let value = dict["data"] as? NSArray{
            for item in value{
                categories.append(FetchCategory.init(dict: item as! [String : Any?]))
            }
        }
    }
}

class FetchProductTypeResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    var productType = [FetchProductType]()
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
        if let value = dict["data"] as? NSArray{
            for item in value{
                productType.append(FetchProductType.init(dict: item as! [String : Any?]))
            }
        }
        
        
    }
}

class FetchProductType :NSObject {
    var type_id:Int = 0
    var typeName:String = ""
    var type_pic:String = ""
    var created_date:String = ""
    var last_updated_date:String = ""
    init(dict:[String:Any?]) {
        if let value = dict["type_id"] as? Int{
            type_id = value
        }
        if let value = dict["typeName"] as? String{
            typeName = value
        }
        if let value = dict["type_pic"] as? String{
            type_pic = value
        }
        if let value = dict["created_date"] as? String{
            created_date = value
        }
        if let value = dict["last_updated_date"] as? String{
            last_updated_date = value
        }
    }
}

class FetchCategory : NSObject{
    var category_id:Int = 0
    var category_pic:String = ""
    var categoryName:String = ""
    var gradient1:String = ""
    var gradient2:String = ""
    var created_date:String = ""
    var last_updated_date:String = ""
    var subCategories = [FetchSubCategory]()
    init(dict:[String:Any?]) {
        if let value = dict["categoryName"] as? String{
            categoryName = value
        }
        if let value = dict["category_id"] as? Int{
            category_id = value
        }
        if let value = dict["categoryImage"] as? String{
            category_pic = value
        }
        if let value = dict["gradient1"] as? String{
            gradient1 = value
        }
        if let value = dict["gradient2"] as? String{
            gradient2 = value
        }
        if let value = dict["created_date"] as? String{
            created_date = value
        }
        if let value = dict["last_updated_date"] as? String{
            last_updated_date = value
        }
        if let value = dict["subCategories"] as? NSArray{
            for item in value{
                subCategories.append(FetchSubCategory.init(dict: item as! [String : Any?]))
            }
        }
    }
}

class FetchSubCategory : NSObject{
    var subcat_id:Int = 0
    var subCategoryName:String = ""
    var gradient1:String = ""
    var subcat_pic:String = ""
    var gradient2:String = ""
    var created_date:String = ""
    var last_updated_date:String = ""
    init(dict:[String:Any?]) {
        if let value = dict["subcat_id"] as? Int{
            subcat_id = value
        }
        if let value = dict["subCategoryName"] as? String{
            subCategoryName = value
        }
        if let value = dict["color_gradient1"] as? String{
            gradient1 = value
        }
        if let value = dict["subCategoryImage"] as? String{
            subcat_pic = value
        }
        if let value = dict["color_gradient2"] as? String{
            gradient2 = value
        }
        if let value = dict["created_date"] as? String{
            created_date = value
        }
        if let value = dict["last_updated_date"] as? String{
            last_updated_date = value
        }
    }
}

class FetchFeedbackResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
    }
}

class OfferDishesResponseModel : NSObject{
    var dishes = [Dishes]()
    init(arr:(NSArray)) {
        for item in arr{
            if let it = item as? [String : Any?]{
                dishes.append(Dishes.init(dict: it ))
            }
        }
    }
}

class ReadyNowDishesResponseModel : NSObject{
    var dishes = [Dishes]()
    init(arr:(NSArray)) {
        for item in arr{
            if let it = item as? [String : Any?]{
                dishes.append(Dishes.init(dict: it ))
            }
        }
    }
}

class Dishes : NSObject{
    var DishAmount:Float = 0.0
    var DishCategory:Int = 0
    var DishDescription:String = ""
    var DishId:Int = 0
    var DishImage:String = ""
    var DishMainCategory:Int = 0
    var DishName:String = ""
    var DishQuantity:String = "'"
    var DishServe:Int = 0
    var DishTime:String = ""
    var KitchenId:Int = 0
    var MenuId:Int = 0
    init(dict:[String:Any?]) {
        //        if let value = dict["KitchenId"] as? String{
        //            if let kitchenID = Int(value){
        //                catId = kitchenID
        //            }
        //        }
        if let value = dict["DishAmount"] as? Float{
            DishAmount = value
        }
        if let value = dict["DishCategory"] as? String{
            if let dishCategory = Int(value){
                DishCategory = dishCategory
            }
        }
        if let value = dict["DishDescription"] as? String{
            DishDescription = value
        }
        if let value = dict["DishId"] as? Int{
            DishId = value
        }
        if let value = dict["DishImage"] as? String{
            DishImage = value
        }
        if let value = dict["DishMainCategory"] as? String{
            if let dishMainCategory = Int(value){
                DishMainCategory = dishMainCategory
            }
        }
        if let value = dict["DishName"] as? String{
            DishName = value
        }
        if let value = dict["DishQuantity"] as? String{
                DishQuantity = value
        }
        if let value = dict["DishServe"] as? String{
            if let dishServe = Int(value){
                DishServe = dishServe
            }
        }
        if let value = dict["DishTime"] as? String{
            DishTime = value
        }
        if let value = dict["KitchenId"] as? Int{
            KitchenId = value
        }
        if let value = dict["MenuId"] as? Int{
            MenuId = value
        }
    }
}
