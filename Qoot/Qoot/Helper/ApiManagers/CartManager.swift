//
//  CartManager.swift
//  Fetch
//
//  Created by Bibin Mathew on 7/5/18.
//  Copyright © 2018 CL. All rights reserved.
//

import UIKit

class CartManager: CLBaseService {
    
    //MARK: Get All Products Api
    
    func callingGetAllCartItemsApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForGetAllCarts(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getCartResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForGetAllCarts(with body:String)->CLNetworkModel{
        let registerRequestModel = CLNetworkModel.init(url: BASE_URL+GET_CART_LIST, requestMethod_: "POST")
        registerRequestModel.requestBody = body
        return registerRequestModel
    }
    func getCartResponseModel(dict:[String : Any?]) -> Any? {
        let productResponseModel = CartListResponseModel.init(dict:dict)
        return productResponseModel
    }
    
    func callingAddToCartApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForAddToCarts(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getCartResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForAddToCarts(with body:String)->CLNetworkModel{
        let registerRequestModel = CLNetworkModel.init(url: BASE_URL+ADD_TO_CART, requestMethod_: "POST")
        registerRequestModel.requestBody = body
        return registerRequestModel
    }
   
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
   
}

class CartListResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    var totalAmount:Double = 0
    var cartArray = [FetchCartItem]()
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
        if let value = dict["Total_amount"] as? Double{
            totalAmount = value
        }
        if let value = dict["data"] as? NSArray{
            for item in value{
                cartArray.append(FetchCartItem.init(dict: item as! [String : Any?]))
            }
        }
    }
}

class FetchCartItem : NSObject{
    var count:Int = 0
    var cartId:Int = 0
    var lastUpdatedDate:String = ""
    var price:Double = 0
    var prodDescription:String = ""
    var prodName:String = ""
    var prodId:Int = 0
    var prodType:Int = 0
    var prodSubCatId:Int = 0
    var prodCategory:String = ""
    var availability:Int = 0
    var brand:String = ""
   
    init(dict:[String:Any?]) {
        if let value = dict["count"] as? Int{
            count = value
        }
        if let value = dict["id"] as? Int{
            cartId = value
        }
        if let value = dict["last_updated_date"] as? String{
            lastUpdatedDate = value
        }
        if let value = dict["price"] as? Double{
            price = value
        }
        if let value = dict["prod_description"] as? String{
            prodDescription = value
        }
        if let value = dict["productName"] as? String{
            prodName = value
        }
        if let value = dict["product_id"] as? Int{
            prodId = value
        }
        if let value = dict["product_type"] as? Int{
            prodType = value
        }
        if let value = dict["subcategory_id"] as? Int{
            prodSubCatId = value
        }
        if let value = dict["categoryName"] as? String{
            prodCategory = value
        }
        if let value = dict["availability"] as? Int{
            availability = value
        }
        if let value = dict["brand_name"] as? String{
            brand = value
        }
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

