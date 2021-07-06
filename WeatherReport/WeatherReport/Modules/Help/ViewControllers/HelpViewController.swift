//
//  HelpViewController.swift
//  WeatherReport
//
//  Created by Kittu Lalli on 06/07/21.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
    }
    
    private func setupWebView() {
        guard let htmlPath = Bundle.main.path(forResource: "Help", ofType: "html") else { return }
        let htmlUrl = URL(fileURLWithPath: htmlPath, isDirectory: false)
        webView.loadFileURL(htmlUrl, allowingReadAccessTo: htmlUrl)
    }
}
