//
//  TableViewCell.swift
//  MoreDetailList
//
//  Created by 박형환 on 2022/10/01.
//

import Foundation
import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    
    
    var navigatingDelegate: NavigatingDelegate?
  
    
    private lazy var imageview: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(red: 0.169, green: 0.169, blue: 0.169, alpha: 1)
        return label
    }()
    
    private lazy var separatorline: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.855, green: 0.859, blue: 0.871, alpha: 1)
        return view
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "vector"), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(_ :)), for: .touchUpInside)
        return button
    }()

    @objc private func buttonTapped(_ sender: UIButton){
        self.navigatingDelegate?.navigating(self.label.text!)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("required init fatalError")
        
    }
    
    func updateUI(_ list: String,
                  _ image: String,
                  _ delegate: NavigatingDelegate) {
        self.label.text = list
        self.imageview.image = UIImage(named: image)
        self.navigatingDelegate = delegate
    }
    
    func configure() {
        
        [imageview,label,separatorline,button].forEach{
            self.contentView.addSubview($0)
        }
        
        imageview.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(20)
            $0.centerY.equalToSuperview()
        }
        
        label.snp.makeConstraints{
            $0.leading.equalTo(imageview.snp.trailing).offset(13)
            $0.centerY.equalToSuperview()
        }
        
        separatorline.snp.makeConstraints{
            $0.height.equalTo(1)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview()
        }
        
        button.snp.makeConstraints{
            
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(40)
        }
        
    }
    
}
