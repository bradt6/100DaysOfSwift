//
//  DetailViewController.swift
//  consolidation6
//
//  Created by Brad Thurlow on 1/4/19.
//  Copyright © 2019 Brad Thurlow. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var detailItem: Country?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else { return }
        
        let html = """
        <html>
        <head>
        <meta name = "viewport" content = "width=device-width, intial-scale=1">
        <style> body {font-size: 150%; } </style>
        </head>
        <body>
            \(detailItem.population)
            \(detailItem.language)
            \(detailItem.name)
        
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
