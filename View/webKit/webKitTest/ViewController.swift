//
//  ViewController.swift
//  webKitTest
//
//  Created by 강병우 on 2020/07/01.
//  Copyright © 2020 강병우. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    // MARK: - Property
    weak var webKitView: WKWebView?
    
    // MARK: - View Life Cycle
    override func loadView() {
        // rootView
        let view = UIView()
        self.view = view
        
        // WebKitView
        let webConfiguration = WKWebViewConfiguration()
        let webKitView: WKWebView = WKWebView(frame: .zero, configuration: webConfiguration)
        self.webKitView = webKitView
        webKitView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webKitView)
        
        // WebKitView 제약사항
        NSLayoutConstraint.activate([
            webKitView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            webKitView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            webKitView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            webKitView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUrl()
        // 스와이프를 통해서 뒤로가기 앞으로가기를 할수 있게 해주는 설정값 입니다.
        self.webKitView?.allowsBackForwardNavigationGestures = true
    }
    
    // MARK: - Func
    func loadUrl() {
        if let url = URL(string: "https://www.naver.com") {
            let urlRequest = URLRequest(url: url)
            webKitView?.load(urlRequest)
        } else {
            // 에러처리문.. 예를들어서 alert를 띄워주거나..
            print("에러")
        }
    }
}


