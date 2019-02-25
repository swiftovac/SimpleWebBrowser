//
//  ViewController.swift
//  SimpleWebBrowser
//
//  Created by Stefan Milenkovic on 2/25/19.
//  Copyright © 2019 Stefan Milenkovic. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
 
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://hackingwithswift.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))

    }
    
    
    @objc func openTapped() {
        
        let vc = UIAlertController(title: "Pick page to open", message: nil, preferredStyle: .actionSheet)
        
        vc.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
        
          vc.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
          vc.addAction(UIAlertAction(title: "google.rs", style: .default, handler: openPage))
          vc.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
        
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(vc, animated: true, completion: nil)
    }
    
    
    
    func openPage(aciton: UIAlertAction) {
        
        guard let actionTitle = aciton.title else {
            return
        }
        guard let url = URL(string: "https://" + actionTitle) else {return}
        
        
        webView.load(URLRequest(url: url))
        

    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        title = webView.title
    }

}

