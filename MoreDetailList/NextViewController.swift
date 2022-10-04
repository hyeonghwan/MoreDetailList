//
//  NextViewController.swift
//  MoreDetailList
//
//  Created by 박형환 on 2022/10/01.
//

import Foundation
import UIKit
import SnapKit
import WebKit

protocol Next{
    var image: String { get }
    var name: String { get }
    var accessType: AccessType { get }
}

protocol OpenWebDelegate{
    func openWeb(_ url: URL,_ title: String)
}

enum AccessType {
    case apple
    case naver
    case google
}

class NextViewController: UIViewController{
    
    var navigationTitle: String
    
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textColor = .label
        label.numberOfLines = 3
        label.text = "안녕하세요 \n빡코빡코딩 고객센터입니다.\n무엇을 도와드릴까요?"
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.separatorStyle = .none
        table.alwaysBounceVertical = false
        table.dataSource = self
        table.contentMode = .center
        table.allowsSelection = false
        return table
    }()
    
    struct NextCellData: Next {
        
        let image: String
        let name: String
        let accessType: AccessType
    }
    let cellData = [NextCellData(image: "question", name: "자주 묻는 질문",accessType: .apple),
                    NextCellData(image: "advertise", name: "광고문의",accessType: .naver),
                    NextCellData(image: "cart", name: "입점문의",accessType: .google)]
    
    
    init(navigationTitle: String) {
        self.navigationTitle = navigationTitle
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationConfigure()
        viewConfigure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = navigationTitle
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("nextViewController viewWilldissaper")
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func getWebViewController(_ url: URL,_ title: String) -> UIViewController? {
        return WebViewContainer(url: url,title: title)
    }
    
}

extension NextViewController: OpenWebDelegate {
   
    func openWeb(_ url: URL,_ title: String) {
        
        if let webViewController = getWebViewController(url,title){
            guard let wv = webViewController as? WebViewContainer else {return}
            
            DispatchQueue.main.async {
                wv.view.setNeedsLayout()
            }
            self.navigationItem.title = ""
            self.show(wv, sender: nil)
        }
    }
    
}

private extension NextViewController{
    
    func navigationConfigure() {
        self.view.backgroundColor = .tertiarySystemBackground
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    func viewConfigure() {
        [label,tableView].forEach{
            self.view.addSubview($0)
        }
        label.snp.makeConstraints{
            $0.top.equalToSuperview().inset(114)
            $0.leading.equalToSuperview().inset(16)
            
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(label.snp.bottom).offset(40)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
}


extension NextViewController: UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NextCell()
        cell.updateUI(self.cellData[indexPath.row],self)
        
        cell.selectionStyle = .none
        return cell
    }
}
