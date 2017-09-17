//
//  BookPreviewViewController.swift
//  BookApplication
//
//  Created by Babu Gangatharan on 9/17/17.
//  Copyright © 2017 Babu Gangatharan. All rights reserved.
//

import UIKit
import Foundation
import SafariServices
import WebKit

class BookPreviewViewController: UIViewController {
    
    //MARK: Properties
    
    var webView : WKWebView!
    var previewUrl: String?
    
    //MARK: Helpers
    
    private func setupView(){
        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeAction))
        
        title = "Book Preview"
        navigationItem.rightBarButtonItem = closeButton
    }
    
    private func configureWebView() {
        guard let urlString = previewUrl else {
            return
        }
        
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        // init and load request in webview.
        webView = WKWebView(frame: self.view.frame)
        webView.navigationDelegate = self
        
        webView.load(request)
        view.addSubview(webView)
        view.sendSubview(toBack: webView)
    }
    
    //MARK: Actions
    
    @objc
    private func closeAction(){
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: UIView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        configureWebView()
    }
    
}

//MARK:- WKNavigationDelegate

extension BookPreviewViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
    }
    
}
