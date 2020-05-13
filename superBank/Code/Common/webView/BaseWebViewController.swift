//
//  BaseWebViewController.swift
//  superBank
//
//  Created by Jaime Tejeiro on 14/05/2020.
//  Copyright © 2020 Jaime Tejeiro. All rights reserved.
//

import UIKit
import WebKit

class BaseWebViewController: UIViewController , WKUIDelegate{
    
    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            webView.leftAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            webView.bottomAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            webView.rightAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    func setupView(urlPage:String) {
        let myURL = URL(string: urlPage )
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    func setupTitle(title:String) {
        self.navigationItem.title = title
    }
    
    
}
// MARK: Configurator
extension BaseWebViewController {
 
    
    @objc class func showBaseWebViewController(title:String,urlPager:String)-> BaseWebViewController {
        let vc =  BaseWebViewController()
        vc.setupView(urlPage: urlPager)
        vc.setupTitle(title: title)
        return vc
    }
    
    
}
