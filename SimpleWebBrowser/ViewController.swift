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
    //var textField: UITextField = UITextField()
    var progressView: UIProgressView!
    
    var websites = ["apple.com", "hackingwithswift.com","google.com"]

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
 
//
//        textField.placeholder = "Enter adress"
//        textField.frame.size.width = 300
//        textField.borderStyle = .roundedRect
//        textField.clearButtonMode = .whileEditing
       
        //navigationItem.titleView = textField
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(webView.reload))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progress = UIBarButtonItem(customView: progressView)
        
        
        
        toolbarItems = [progress, spacer, refreshButton]
        navigationController?.isToolbarHidden = false

        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        

        // adding observer
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
    }
    
    
    @objc func openTapped() {
        
        let vc = UIAlertController(title: "Pick page to open", message: nil, preferredStyle: .actionSheet)

        for website in websites {
            vc.addAction(UIAlertAction(title: website, style: .default, handler: openPage))

        }
          vc.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))

        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true, completion: nil)
        
        //openeEnteredAdress()
        
    }
    
    
    
    func openPage(aciton: UIAlertAction) {



        guard let actionTitle = aciton.title else {
            return
        }
        guard let url = URL(string: "https://" + actionTitle) else {return}


        webView.load(URLRequest(url: url))


    }
    
//    func openeEnteredAdress() {
//
//        guard let adress = textField.text else {
//            return
//        }
//        guard let url = URL(string: "https://" + adress) else {return}
//        webView.load(URLRequest(url: url))
//
//    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
            
        }
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let url = navigationAction.request.url
        
        if let host = url?.host {
            
            for website in websites {
                if host.contains(website){
                    decisionHandler(.allow)
                    return
                }
            }
            
        }
        
        decisionHandler(.cancel)
    }
  

}

