//
//  FetchApiUrls.swift
//  Fetch
//
//  Created by Bibin Mathew on 6/25/18.
//  Copyright © 2018 CL. All rights reserved.
//

import UIKit

let LOCAL  = "http://34.214.67.129/kpFetch/index.php/"
let PRODUCTION  = "http://localhost/kpFetch/index.php/"

let BASE_URL = LOCAL
let LOGIN_URL = "user/signIn"
let REGISTER_URL = "user/signUp"
let FORGOT_PASS_URL = "user/forgotPassword"
let CHANGE_PASS_URL = "user/changePassword"
let EDIT_PROFILE_URL = "user/editProfile"
let GET_LOCATIONS_URL = "location/allLocations"
let GET_CATEGORIES_URL = "category/allCategories"
let GET_CAT_SUBCAT_URL = "category/getCategoriesSub"
let GET_CAT_TYPES = "category/getProductsTypeList"
let GET_ALL_PRODUCTS = "category/getProductsList"
let GET_ALL_PRO_FROM_SUBCAT = "category/ProductFromSubcategory"
let GET_PRODUCT_DETAILS = "category/getProductDetails"
let GET_ALL_SEARCH_PRODUCTS = "category/searchProduct"
let GET_CART_LIST = "purchase/getMyCartDetails"
let GET_CART_LIST_HISTORY = "purchase/purchaseHistory"
let ADD_TO_CART = "purchase/addToCart"
let CHECK_OUT_URL = "order/checkOutMyCart"
let GET_COUPON_CODE = "order/promotionalCode"
let TERMS_AND_CONDITIONS = "documents/termsConditions"
let PAYMENT_URL = "payment/processPayment"
let GET_NOTIFICATIONS = "user/getMySettings"
let GET_NOTIFICATIONS_HISTORY = "notification/getMyNotificationHistory"
let REMOVE_NOTIFICATIONS = "notification/myNotificationRemove"
let CHANGE_NOTIFICATIONS = "user/changeMySettings"
let ADD_FEEDBACK_URL = "application/submitMyFeedback"
let LOGOUT_URL = "user/signOut"
let CONTACT_US_URL = "application/submitContactForm"

let GET_BRANDS_URL = "category/getAllBrands"
let GET_BREEDS_URL = "category/getAllBreeds"