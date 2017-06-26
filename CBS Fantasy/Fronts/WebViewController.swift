//
//  WebViewController.swift
//  CBS Fantasy
//
//  Created by Punit Kulkarni on 6/26/17.
//  Copyright © 2017 Punit Kulkarni. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView! {
        didSet {
            webView.delegate = self
        }
    }
    var urlString: String? {
        didSet {
            if isViewLoaded {
                guard urlString != nil,
                let url = URL(string: urlString!) else { return }
                self.webView.loadRequest(URLRequest(url: url))
            }
        }
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard urlString != nil,
            let url = URL(string: urlString!) else { return }
        self.webView.loadRequest(URLRequest(url: url))
    }
}

extension WebViewController: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        hideHUD()
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        //showHUD()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        hideHUD()
    }
}