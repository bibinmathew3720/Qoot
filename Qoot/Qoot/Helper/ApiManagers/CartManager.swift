//
//  CartManager.swift
//  Fetch
//
//  Created by Bibin Mathew on 7/5/18.
//  Copyright © 2018 CL. All rights reserved.
//

import UIKit

class CartManager: CLBaseService {
    
   
   
    //MARK: CheckOut Api
    
    func callingCheckOutApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForCheckOut(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getCheckOutResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForCheckOut(with body:String)->CLNetworkModel{
        let checkOutRequestModel = CLNetworkModel.init(url: BASE_URL+CHECK_OUT_URL, requestMethod_: "POST")
        checkOutRequestModel.requestBody = body
        return checkOutRequestModel
    }
    func getCheckOutResponseModel(dict:[String : Any?]) -> Any? {
        let checkOutRequestModel = CheckOutResponseModel.init(dict:dict)
        return checkOutRequestModel
    }
    
    //MARK: Get CouponCode Api
    
    func callingCouponCodeApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelCouponCode(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getCouponCodeResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelCouponCode(with body:String)->CLNetworkModel{
        let CouponCodeRequestModel = CLNetworkModel.init(url: BASE_URL+GET_COUPON_CODE, requestMethod_: "POST")
        CouponCodeRequestModel.requestBody = body
        return CouponCodeRequestModel
    }
    func getCouponCodeResponseModel(dict:[String : Any?]) -> Any? {
        let CouponCodeRequestModel = CouponCodeResponseModel.init(dict:dict)
        return CouponCodeRequestModel
    }
    
    
    //MARK: Calling Payment Api
    
    func callingPaymentApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForPayment(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getPaymentResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForPayment(with body:String)->CLNetworkModel{
        let CouponCodeRequestModel = CLNetworkModel.init(url: BASE_URL+PAYMENT_URL, requestMethod_: "POST")
        CouponCodeRequestModel.requestBody = body
        return CouponCodeRequestModel
    }
    
    func getPaymentResponseModel(dict:[String : Any?]) -> Any? {
        let paymentResponseModel = PaymentResponseModel.init(dict:dict)
        return paymentResponseModel
    }
    
    //MARK: Get Delivery Addresses Api
    
    func callingGetAddressessApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForGetAllAddresses(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveArrayResponseSuccessFully(resultData)
            
            
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getAllAddressesResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForGetAllAddresses(with body:String)->CLNetworkModel{
        let addressRequestModel = CLNetworkModel.init(url: BASE_URL+GetAllAddresses_URL, requestMethod_: "POST")
        addressRequestModel.requestBody = body
        return addressRequestModel
    }
    
    func getAllAddressesResponseModel(dict:NSArray) -> Any? {
        let addressesResponseModel = AddressResponseModel.init(arr:dict)
        return addressesResponseModel
    }
   
}

class CheckOutResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    var purchase_Id:Int = 0
    var user_Id:Int = 0
    var deliveryCharge:Double = 0
    var deleveryDate:String = ""
    var totalAmount:Double = 0
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
        if let value = dict["purchase_id"] as? Int{
            purchase_Id = value
        }
        if let value = dict["user_id"] as? Int{
            user_Id = value
        }
        if let value = dict["delivery_charge"] as? Double{
            deliveryCharge = value
        }
        if let value = dict["total_amount"] as? Double{
            totalAmount = value
        }
        if let value = dict["delivery_date"] as? String{
            deleveryDate = value
        }
    }
}

class CouponCodeResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    var discount:Double = 0
    var grandTotalAmount:Double = 0
    // var product:FetchProduct?
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
        if let value = dict["grandTotal"] as? Double{
            grandTotalAmount = value
        }
        if let value = dict["discount"] as? Double{
            discount = value
        }
    }
}

class PaymentResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    var paymentUrl:String = ""
    var paymentMode:String = ""
    // var product:FetchProduct?
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
        if let value = dict["paymentUrl"] as? String{
            paymentUrl = value
        }
        if let value = dict["paymode"] as? String{
            paymentMode = value
        }
      
    }
}

class AddressResponseModel : NSObject{
    var addresses = [Address]()
    init(arr:(NSArray)) {
        for item in arr{
            if let it = item as? [String : Any?]{
                addresses.append(Address.init(dict: it ))
            }
        }
    }
}

class Address : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    var paymentUrl:String = ""
    var paymentMode:String = ""
    // var product:FetchProduct?
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
        if let value = dict["paymentUrl"] as? String{
            paymentUrl = value
        }
        if let value = dict["paymode"] as? String{
            paymentMode = value
        }
        
    }
}

