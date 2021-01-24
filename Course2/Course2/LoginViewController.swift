//
//  LoginViewController.swift
//  Course2
//
//  Created by N!kS on 02.12.2020.
//

import UIKit
import WebKit

class LoginViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!

    
    override func viewDidLoad() {
            super.viewDidLoad()
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems=[
            URLQueryItem.init(name: "client_id", value: "7725605"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_url", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "wall, friends, groups, photos"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        let request = URLRequest(url: urlComponents.url!)
        webView.navigationDelegate = self
        webView.load(request)
        }
    }

extension LoginViewController {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
                url.path == "/blank.html",
                let fragment = url.fragment  else {
                decisionHandler(.allow)
                return
                }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
              
        let token = params["access_token"]
        let userID = params["user_id"] ?? ""
        UserSession.instance.id = UInt(Int(userID) ?? 0)
        UserSession.instance.token = token ?? ""
        print(token ?? "false")
        print(userID )
        print("success")

       performSegue(withIdentifier: "VKLogin", sender: nil)
        decisionHandler(.cancel)
    }
}
    

