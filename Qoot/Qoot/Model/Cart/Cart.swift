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
    static func addProductToCart(dish:Dishes, kitchen:ViewKitchens){
        var cart:Cart?
        let cartPredicate = NSPredicate(format: "productId==%d",dish.MenuId)
        let cartArray = CoreDataHandler.sharedInstance.getAllDatasWithPredicate(entity: "Cart", predicate:cartPredicate , sortDescriptor: nil)
        if (cartArray.count == 0){
            cart = CoreDataHandler.sharedInstance.newEntityForName(entityName: "Cart") as? Cart
            cart?.productCount = Int64(dish.SelectedQuantity)
        }
        else{
            cart = cartArray.first as? Cart
            cart?.productCount = Int64(dish.SelectedQuantity)
            //cart?.productCount += Int64(dish.SelectedQuantity)
        }
        cart?.productId = Int64(dish.MenuId)
        cart?.menuId = Int64(dish.MenuId)
        cart?.productName = dish.DishName
        cart?.productPrice = Float(dish.DishAmount)
        cart?.deliveryFee = kitchen.KitchenDeliveryFee
        cart?.kitchenId = Int64(kitchen.KitchenId)
       // cart?.availability = Int64(dish.DishQuantity)!
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
        let cartArray = CoreDataHandler.sharedInstance.getAllDatas(entity: "Cart") as? [Cart]
        for item   in cartArray!{
            let prodPrice = Double(item.productPrice)
            let countDouble:Double = Double(item.productCount)
            totalAmount = totalAmount + prodPrice * countDouble
        }
        return totalAmount
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
