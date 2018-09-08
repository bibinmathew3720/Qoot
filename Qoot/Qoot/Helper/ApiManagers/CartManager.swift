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
   
    
    //MARK: Add Customer Order Api
    
    func addCustomerOrderApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForAddCustomerOrder(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict as Any)
                    success(self.addCustomerOrderResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
        }, failiure: {(error)-> () in failure(error)
            
        })
    }
    
    func networkModelForAddCustomerOrder(with body:String)->CLNetworkModel{
        let addressRequestModel = CLNetworkModel.init(url: BASE_URL+AddCustomerOrder_URL, requestMethod_: "POST")
        addressRequestModel.requestBody = body
        return addressRequestModel
    }
    
    func addCustomerOrderResponseModel(dict:[String : Any?]) -> Any? {
        let addressesResponseModel = AddCustomerOrderResponseModel.init(dict:dict)
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

class AddCustomerOrderResponseModel : NSObject{
    var statusMessage:String = ""
    var statusCode:Int = 0
    var order_Id:Int = 0
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
        if let value = dict["orderid"] as? Int{
            order_Id = value
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
    var addressId:Int = 0
    var customerId:Int = 0
    var customerLocationName:String = ""
    var deliveryAddress:String = ""
    var deliveryCity:String = ""
    var deliveryLandMark:String = ""
    var deliveryMapLocation:String = ""
    var deliveryNickName:String = ""
    var deliveryPhoneNumber:String = ""
    var deliveryState:String = ""
    var deliveryCoordinates:String = ""
    init(dict:[String:Any?]) {
        if let value = dict["address_id"] as? String{
            if let addID = Int(value){
                addressId = addID
            }
        }
        if let value = dict["customer_id"] as? String{
            if let cusID = Int(value){
                customerId = cusID
            }
        }
        if let value = dict["customer_location_name"] as? String{
            customerLocationName = value
        }
        if let value = dict["delivary_address"] as? String{
            deliveryAddress = value
        }
        if let value = dict["delivary_city"] as? String{
            deliveryCity = value
        }
        if let value = dict["delivary_landmark"] as? String{
            deliveryLandMark = value
        }
        if let value = dict["delivary_map_location"] as? String{
            deliveryMapLocation = value
        }
        if let value = dict["delivary_nick_name"] as? String{
            deliveryNickName = value
        }
        if let value = dict["delivary_phone_number"] as? String{
            deliveryPhoneNumber = value
        }
        if let value = dict["delivary_state"] as? String{
            deliveryState = value
        }
        if let value = dict["delivery_coordinates"] as? String{
            deliveryCoordinates = value
        }
    }
}

