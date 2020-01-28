//
//  BaseWebviewController.swift
//  BasicFramework
//
//  Created by Jivan on 2018/11/17.
//  Copyright © 2018 Jivan. All rights reserved.
//

import UIKit
import WebKit

class BaseWebviewController: JHBaseViewController {
    
    let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
    let progressView = UIProgressView()
    open var url: URL?
    open var htmlString:String?
    // MARK: Life cycle
    public convenience init(_ url: URL) {
        self.init()
        self.url = url
        
    }
    public convenience init(_ htmlString: String) {
        self.init()
        self.htmlString = htmlString
        
    }
    
    deinit {
        if self.isViewLoaded {
            
            self.webView.removeObserver(self, forKeyPath: "estimatedProgress", context: nil)
            self.webView.removeObserver(self, forKeyPath: "title", context: nil)
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        self.webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        
        
        if (self.url != nil) {
            
            self.loadRequest()
        }
        if self.htmlString != nil {
            
            self.loadHtmlString()
        }
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if (self.url != nil) {
            
            self.progressView.frame = CGRect(x: 0, y: 0 - self.webView.scrollView.bounds.origin.y, width: self.webView.bounds.size.width, height: 2.0)
        }
        
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func initUI() {
        self.view.backgroundColor = .white
        
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.webView)
        let views: [String : Any]
        // webView constraints
        if #available(iOS 11.0, *) {
            views  = ["webView" : self.webView,"topLayoutGuide" : self.view.safeAreaLayoutGuide.topAnchor]
        }else{
            
            views = ["webView" : self.webView,"topLayoutGuide" : self.topLayoutGuide]
        }
        
        
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[webView]-0-|", options: [], metrics: nil, views: views)
        var vvf = "V:[topLayoutGuide]-0-[webView]-0-|"
        if self.navigationController != nil {
            vvf = "V:|-0-[webView]-0-|"
        }
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: vvf, options: [], metrics: nil, views: views)
        self.view.addConstraints(hConstraints)
        self.view.addConstraints(vConstraints)
        
        self.webView.allowsBackForwardNavigationGestures = true
        if self.url != nil {
            self.webView.addSubview(self.progressView)
            self.progressView.progress = 0.1 // to fix short time blank when view did load
        }
        
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath {
            switch keyPath {
            case "estimatedProgress":
                let newProgress = change![.newKey] as? Float
                switch newProgress {
                case 0.0:
                    self.progressView.isHidden = false
                    
                case 1.0:
                    self.progressView.progress = newProgress!
                    delay(0.5, closure: {
                        UIView.animate(withDuration: 0.2, animations: {
                            self.progressView.isHidden = true
                        })
                    })
                    
                default:
                    self.progressView.progress = newProgress ?? 0.1
                    self.progressView.isHidden = false
                }
                
            case "title":
                let title = change![.newKey] as! String
                self.title = title
                
            default:
                break
            }
        }
    }
    
    // MARK: - private
    open func loadRequest() {
        
        if let url = self.url {
            let request = NSMutableURLRequest(url: url, cachePolicy:.useProtocolCachePolicy, timeoutInterval: 86400)
            
            // add request cookie here
            //            request.addValue("key=value;", forHTTPHeaderField: "Cookie")
            
            webView.load(request as URLRequest)
        }
    }
    
    open func loadHtmlString() {
        
        if let html = self.htmlString {
            
            webView.loadHTMLString(html, baseURL: nil)
        }
    }
    
    
    func delay(_ delay:Double? = 1.0, closure:@escaping ()->Void) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay! * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure
        )
    }
    
}

