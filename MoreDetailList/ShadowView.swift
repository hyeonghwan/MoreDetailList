//
//  ShadowView.swift
//  MoreDetailList
//
//  Created by 박형환 on 2022/10/02.
//

import Foundation
import UIKit


class ShadowView: UIView {
    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }
    
    func createShadowLayer() -> CALayer {
        let shadowLayer = CALayer()
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = CGSize.zero
        shadowLayer.shadowOffset = CGSize(width: 2, height: 2)
        shadowLayer.shadowRadius = 3
        shadowLayer.shadowOpacity = 0.5
        shadowLayer.backgroundColor = UIColor.clear.cgColor
        return shadowLayer
    }
    
    private func setupShadow(){
        let line = CAShapeLayer()
        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 12)
        line.path = path.cgPath
        line.strokeColor = UIColor.lightGray.cgColor
        line.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(line)

        let shadowSubLayer = createShadowLayer()
        shadowSubLayer.insertSublayer(line, at: 0)
        self.layer.addSublayer(shadowSubLayer)
        
    }
}
