//
//  ViewController.swift
//  MoreDetailList
//
//  Created by 박형환 on 2022/10/01.
//

import UIKit

protocol NavigatingDelegate {
    func navigating(_ title: String)
}

class ViewController: UIViewController {
    

    
    
    struct DetailList{
        let list: String
        let image: String
    }
    let list: [DetailList] = [DetailList(list: "공지사항", image: "notify"),
                              DetailList(list: "앱 설정", image: "setting"),
                              DetailList(list: "고객센터", image: "phone"),
                              DetailList(list: "약관 및 정책", image: "policy")]
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        table.alwaysBounceVertical = false
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 1000;
        return table
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "더보기"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationItem.titleView?.tintColor = .label
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        view.directionalLayoutMargins = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }

}
extension ViewController: NavigatingDelegate{
    func navigating(_ title: String) {
        self.navigationItem.title = ""
        let vc = NextViewController(navigationTitle: title)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath)")
        
    }
    
}
extension ViewController: UITableViewDataSource{

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(55)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewCell(style: .default,
                                 reuseIdentifier: TableViewCell.identify)
        let string = list[indexPath.row].list
        let image = list[indexPath.row].image
        cell.updateUI(string,image,self)
        cell.selectionStyle = .none
        return cell
    }
}


