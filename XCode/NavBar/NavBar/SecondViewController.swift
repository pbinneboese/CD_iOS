//
//  SecondViewController.swift
//  NavBar
//
//  Created by Paul Binneboese on 3/22/17.
//  Copyright © 2017 Paul Binneboese. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var pictures = [String]()

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SecondView DidAppear")

//        let fm = FileManager.default
//        let path = Bundle.main.resourcePath!
//        let items = try! fm.contentsOfDirectory(atPath: path)
//        
//        for item in items {
//            if item.hasSuffix("jpg") {
//                pictures.append(item)
//            }
//        }
//
//        let imageToLoad = pictures[0]
//        imageView.image  = UIImage(named: imageToLoad)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("SecondViewController viewWillAppear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

