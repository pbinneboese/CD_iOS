//
//  DetailViewController.swift
//  WhiteHousePetition
//
//  Created by Paul Binneboese on 3/22/17.
//  Copyright © 2017 Paul Binneboese. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: [String: String]!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard detailItem != nil else { return }
        // format petition detail as HTML
        var title = detailItem["title"]
        if title == nil {
            title = ""
        }
        var body = detailItem["body"]
        if body == nil {
            body = ""
        }
        var sigs = detailItem["sigs"]
        if sigs == nil {
            sigs = ""
        }
        var html = "<html>"
        html += "<head>"
        html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
        html += "<style> body { font-size: 150%; } </style>"
        html += "</head>"
        html += "<body>"
        html += "<h3>Title</h3>"
        html += title!
        html += "<h3>Signatures</h3>"
        html += sigs!
        html += "<h3>Description</h3>"
        html += body!
        html += "</body>"
        html += "</html>"
        webView.loadHTMLString(html, baseURL: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
