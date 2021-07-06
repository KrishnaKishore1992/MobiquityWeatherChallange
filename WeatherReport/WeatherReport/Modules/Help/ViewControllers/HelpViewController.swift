//
//  HelpViewController.swift
//  WeatherReport
//
//  Created by Kittu Lalli on 06/07/21.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
    }
    
    private func setupWebView() {
        let jscript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        let userScript = WKUserScript(source: jscript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let wkUController = WKUserContentController()
        wkUController.addUserScript(userScript)
        let wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.userContentController = wkUController
        wkWebConfig.suppressesIncrementalRendering = false
        let webView = WKWebView(frame: .zero, configuration: wkWebConfig)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.showsVerticalScrollIndicator = false
        guard let htmlPath = Bundle.main.path(forResource: "Help", ofType: "html") else { return }
        let htmlUrl = URL(fileURLWithPath: htmlPath, isDirectory: false)
        webView.loadFileURL(htmlUrl, allowingReadAccessTo: htmlUrl)
        webView.backgroundColor = .white
        view.addSubview(webView)
        webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: webView.trailingAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: webView.bottomAnchor, constant: 0).isActive = true
    }
}
