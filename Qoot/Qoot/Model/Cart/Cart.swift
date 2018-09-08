//
//  Cart.swift
//  Fetch
//
//  Created by Bibin Mathew on 7/5/18.
//  Copyright © 2018 CL. All rights reserved.
//

import UIKit
import CoreData

class Cart: NSManagedObject {
    static func addProductToCart(product:FetchProduct){
        var cart:Cart?
        let cartPredicate = NSPredicate(format: "productId==%d",product.productId)
        let cartArray = CoreDataHandler.sharedInstance.getAllDatasWithPredicate(entity: "Cart", predicate:cartPredicate , sortDescriptor: nil)
        if (cartArray.count == 0){
            cart = CoreDataHandler.sharedInstance.newEntityForName(entityName: "Cart") as? Cart
            cart?.productCount = Int64(product.selectedQuantity)
        }
        else{
            cart = cartArray.first as? Cart
            cart?.productCount += Int64(product.selectedQuantity)
        }
        cart?.productId = Int64(product.productId)
        cart?.productName = product.productName
        cart?.productPrice = Float(product.productAmount)
        cart?.availability = Int64(product.productQuantity)
        CoreDataHandler.sharedInstance.saveContext()
    }
    
    static func getAllCartItems()->[Cart]{
        let cartArray = CoreDataHandler.sharedInstance.getAllDatas(entity: "Cart")
        return cartArray as! [Cart]
    }
    
    static func isAlredyAddedToCart(product:FetchProduct)->Cart?{
        let cartPredicate = NSPredicate(format: "productId==%d",product.productId)
        let cartArray = CoreDataHandler.sharedInstance.getAllDatasWithPredicate(entity: "Cart", predicate:cartPredicate , sortDescriptor: nil)
        if cartArray.count>0{
            return cartArray.first as? Cart
        }
       return nil
    }
    
    static func calculateCartAmount()->Double{
        var totalAmount:Double = 0
        let cartArray = CoreDataHandler.sharedInstance.getAllDatas(entity: "Cart")
        for item   in cartArray{
            let prodPrice = Double(item.productPrice)
            let countDouble:Double = Double(item.productCount)
            totalAmount = totalAmount + prodPrice * countDouble
        }
        return totalAmount
    }
    
    static func addAllProductsToCart(cartItems:[FetchCartItem]){
        for cartItem in cartItems{
            var cart:Cart?
            let cartPredicate = NSPredicate(format: "productId==%d",cartItem.prodId)
            let cartArray = CoreDataHandler.sharedInstance.getAllDatasWithPredicate(entity: "Cart", predicate:cartPredicate , sortDescriptor: nil)
            if (cartArray.count == 0){
                cart = CoreDataHandler.sharedInstance.newEntityForName(entityName: "Cart") as? Cart
                cart?.productCount = Int64(cartItem.count)
            }
            else{
                cart = cartArray.first as? Cart
                //cart?.productCount += Int64(cartItem.count)
                // cart?.productCount = Int64(cartItem.count)
            }
            cart?.productId = Int64(cartItem.prodId)
            cart?.productName = cartItem.prodName
            cart?.availability = Int64(cartItem.availability)
            cart?.productPrice = Float(cartItem.price)
            CoreDataHandler.sharedInstance.saveContext()
        }
    }
    
    static func addAllPurchasedProductsToCart(orderItems:[OrderHistory]){
        for orderItem in orderItems{
            var cart:Cart?
            let cartPredicate = NSPredicate(format: "productId==%d",orderItem.product_id)
            let cartArray = CoreDataHandler.sharedInstance.getAllDatasWithPredicate(entity: "Cart", predicate:cartPredicate , sortDescriptor: nil)
            if (cartArray.count == 0){
                cart = CoreDataHandler.sharedInstance.newEntityForName(entityName: "Cart") as? Cart
                cart?.productCount = Int64(orderItem.quantity)
            }
            else{
                cart = cartArray.first as? Cart
                //cart?.productCount += Int64(cartItem.count)
                // cart?.productCount = Int64(cartItem.count)
            }
            cart?.productId = Int64(orderItem.product_id)
            cart?.productName = orderItem.product_name
            cart?.availability = Int64(orderItem.availability)
            cart?.productPrice = Float(orderItem.unit_pricce)
            CoreDataHandler.sharedInstance.saveContext()
        }
    }
    
    static func deletAllItemsFromCart(){
        let cartArray = CoreDataHandler.sharedInstance.getAllDatas(entity: "Cart") as! [Cart]
        for i in 0..<cartArray.count {
           CoreDataHandler.sharedInstance.deleteObject(object: cartArray[i])
            CoreDataHandler.sharedInstance.saveContext()
        }
    }
    
    static func deletCartItem(cartItem:Cart){
        CoreDataHandler.sharedInstance.deleteObject(object: cartItem)
        CoreDataHandler.sharedInstance.saveContext()
    }
    
    static func incrementCartItemCount(cartItem:Cart){
        cartItem.productCount = cartItem.productCount+1
        CoreDataHandler.sharedInstance.saveContext()
    }
    
    static func decrementCartItemCount(cartItem:Cart){
        if(cartItem.productCount > 1){
           cartItem.productCount = cartItem.productCount-1
        }
        CoreDataHandler.sharedInstance.saveContext()
    }
   
}
