//
//  NextCell.swift
//  MoreDetailList
//
//  Created by 박형환 on 2022/10/02.
//

import Foundation
import UIKit
import SnapKit
import WebKit


class NextCell: UITableViewCell{
    
    private var webDelegate: OpenWebDelegate?

    var accessType: AccessType?
    
    private lazy var view: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var shadowView: ShadowView = {
        let view = ShadowView()
        view.backgroundColor = .clear
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:))))
        return view
    }()
    
    private lazy var nameImageView: UIImageView = {
        let imageView = UIImageView()
    
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "vector"), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(_ :)), for: .touchUpInside)
        return button
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("required init fatalError")
        
    }
    
    
    
    @objc func buttonTapped(_ sender: UIView){
        var url: URL?
        switch self.accessType{
        case .apple:
            url =  URL(string: "https://www.apple.com")
        case .naver:
            url =  URL(string: "https://www.naver.com")
        case .google:
            url =  URL(string: "https://www.google.com")
        default:
            print("default error occur")
            break
        }
        if let url = url {
            self.webDelegate?.openWeb(url)
        }
        
    }
    
    
    func updateUI(_ data: Next,_ delegate: OpenWebDelegate) {
        self.nameImageView.image = UIImage(named: "\(data.image)")
        self.label.text = data.name
        self.accessType = data.accessType
        self.webDelegate = delegate
    }
    
    
    private func configure() {
        
        
        self.contentView.addSubview(shadowView)
        
        
        shadowView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(8)
            $0.height.equalTo(84)
        }
        
        [nameImageView,label,button].forEach{
            self.shadowView.addSubview($0)
            centerYequalToSuperview($0)
        }
        
        nameImageView.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16)
            widthEqualHeight(20, $0)
        }
        label.snp.makeConstraints{
            $0.leading.equalTo(nameImageView.snp.trailing).offset(10)
        }
        button.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(16)
            widthEqualHeight(20, $0)
        }
        
        func centerYequalToSuperview(_ item: UIView){
            item.snp.makeConstraints{
                $0.centerY.equalToSuperview()
            }
        }
        
        func widthEqualHeight(_ size: CGFloat,_ maker: ConstraintMaker ){
            maker.width.equalTo(size)
            maker.height.equalTo(size)
        }
    }
    
}
