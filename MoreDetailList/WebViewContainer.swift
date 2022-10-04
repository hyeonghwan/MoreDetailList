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
    
    private var navigationTitle: String?
    
    private var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemCyan
        return view
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        indicator.contentMode = .scaleToFill
        indicator.color = .red
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }()
    
    
    init(url: URL? = nil,title: String) {
        self.url = url
        self.navigationTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .tertiarySystemBackground
        
        webView = WKWebView()
        webView?.navigationDelegate = self
        webView?.uiDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad WebView")
        
        guard let webView = webView else {return}
        self.view.addSubview(containerView)
        
        containerView.addSubview(webView)
        
        setAutoLayout(from: webView, to: containerView)
        self.webView?.addSubview(self.indicator)
        
        indicator.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
        }
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title),options: .new, context: nil)
        if let url = url {
            self.webView?.load(URLRequest(url: url))
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = self.navigationTitle
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.webView?.stopLoading()
        self.containerView = UIView()
    }
    
    deinit{
        print("deinit")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            Float(webView?.estimatedProgress ?? 0) == 1.0 ? self.indicator.stopAnimating() : print("not loded")
        }
        if keyPath == "title" {
            if let title = webView?.title {
                print(title)
            }
        }
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
    
    
    // navigationBar height 구하기
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

extension WebViewContainer: WKUIDelegate{
    func webViewDidClose(_ webView: WKWebView) {
        print("didClosed")
    }
}
