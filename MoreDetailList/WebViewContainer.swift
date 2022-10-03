//
//  WebViewContainer.swift
//  MoreDetailList
//
//  Created by 박형환 on 2022/10/03.
//

import Foundation
import UIKit
import WebKit
import SnapKit


class WebViewContainer: UIViewController {
    
    private var webView: WKWebView?
    
    private var url: URL?
    
    private var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemCyan
        return view
    }()
    
    init(webView: WKWebView, url: URL? = nil) {
        self.webView = webView
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .tertiarySystemBackground
        webView?.navigationDelegate = self
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let webView = webView else {return}
        self.view.addSubview(containerView)
        containerView.addSubview(webView)
        setAutoLayout(from: webView, to: containerView)
        
        if let url = url {
            webView.load(URLRequest(url: url))
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.containerView = UIView()
    }
    
    deinit{
        print("deinit")
        
    }
    
    public func setAutoLayout(from: UIView, to: UIView) {
        let height = getNavigationHeightSize()
        
        to.snp.makeConstraints{
            $0.top.equalToSuperview().offset(height)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        from.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    func getNavigationHeightSize() -> CGFloat{
        var navBarHeight: CGFloat = 0
        if #available(iOS 13.0, *){
           let height = UIApplication.firstKeyWindowForConnectedScenes?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
            navBarHeight = height +
            (navigationController?.navigationBar.frame.height ?? 0.0)
            
        }else {
           navBarHeight = UIApplication.shared.statusBarFrame.size.height +
                     (navigationController?.navigationBar.frame.height ?? 0.0)
        }
        return navBarHeight
    }

    
    
}
extension WebViewContainer: WKNavigationDelegate{
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }

}
