//
//  LoginWebViewController.swift
//  vkClient
//
//  Created by MacBook Pro on 22.12.2020.
//

import UIKit
import WebKit

class LoginWebViewController: UIViewController {

    //MARK: - Private Properties

    private let webView = WKWebView()


    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        //webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        view = webView

        if let request = NetworkService().getAuthorizeRequest() {
            webView.load(request)
        }

    }


    //MARK: - Private Methods

    private func presentLoginViewController() {

        let storyBoard: UIStoryboard = UIStoryboard(name: "LoginScreen", bundle: nil)
        let loginViewController: LoginScreenController = storyBoard.instantiateViewController(withIdentifier: "LoginView") as! LoginScreenController
        self.present(loginViewController, animated: true, completion: nil)
    }


}

extension LoginWebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        guard
            let url = navigationResponse.response.url,
            let fragment = url.fragment,
                url.path == "/blank.html"
        else {
            decisionHandler(.allow)
            return
        }

        let params = fragment
            .components(separatedBy: "&")
            .map( { $0.components(separatedBy: "=") } )
            .reduce([String:String](), { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            })

        Session.shared.token = params["access_token"]
        Session.shared.userId = Int(params["user_id"] ?? "")

        if Session.shared.token != nil {
            self.presentLoginViewController()
        }

        decisionHandler(.cancel)
    }


}
