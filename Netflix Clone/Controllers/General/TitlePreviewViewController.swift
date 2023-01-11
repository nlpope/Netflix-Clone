//
//  TitlePreviewViewController.swift
//  Netflix Clone
//
//  Created by Noah Pope on 1/11/23.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overviewLabel: UILabel = {
       
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0 //0 = can take multiple lines; not constrained to 1 or 2 or ... lines
        return label
    }()
    
    private let webView: WKWebView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    



}
