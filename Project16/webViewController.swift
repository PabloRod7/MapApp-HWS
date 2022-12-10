//
//  WebViewController.swift
//  Project16
//
//  Created by Pablo Rodrigues on 02/12/2022.
//
import WebKit
import UIKit

class MyWebViewController: UIViewController {
    
    var website: String!

    @IBOutlet weak var myWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard website != nil else {
                  print("Website not set")
                  navigationController?.popViewController(animated: true)
                  return
              }
              
              if let url = URL(string: website) {
                  myWebView.load(URLRequest(url: url))
              }
          }

      
    }
    

  

