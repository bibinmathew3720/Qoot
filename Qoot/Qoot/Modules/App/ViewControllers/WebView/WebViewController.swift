//
//  WebViewController.swift
//  Flower
//
//  Created by Vishnu KM on 11/10/18.
//  Copyright © 2018 CL. All rights reserved.
//

import UIKit

class WebViewController: BaseViewController {
    @IBOutlet var webView: UIWebView!
    var urlStr:String?
    
    override func initView() {
        super.initView()
        initialisation()
    }
    
    func initialisation(){
        if let _url = urlStr{
            let myURL = URL(string:_url)
            let myRequest = URLRequest(url: myURL!)
            webView.loadRequest(myRequest)
        }
        addingLeftBarButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
