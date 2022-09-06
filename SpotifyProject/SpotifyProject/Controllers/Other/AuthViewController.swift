//
//  AuthViewController.swift
//  SpotifyProject
//
//  Created by 陳飛 on 21/5/2022.
//

import UIKit
import WebKit

class AuthViewController: UIViewController {
    
    private lazy var webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        if #available(iOS 14.0, *) {
            prefs.allowsContentJavaScript = true
        } else {
            // Fallback on earlier versions
        }
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero,
                                configuration: config)
        return webView
    }()
    
    public var completionHandler: ((Bool) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign in"
        self.view.backgroundColor = .systemBackground
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        guard let url = AuthManager.shared.signInURL else { return }
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = self.view.bounds
    }

}


extension AuthViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = AuthManager.shared.signInURL else { return }
        // exchange the code for access token
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == "code"})?.value else {
            return
        }
        Swift.debugPrint("Code: \(code)")
        AuthManager.shared.exchangeCodeForToken(code: code) { [weak self] success in
            DispatchQueue.main.async {
                self?.navigationController?.popViewController(animated: true)
                self?.completionHandler?(success)
            }
        }
    }
    
}
