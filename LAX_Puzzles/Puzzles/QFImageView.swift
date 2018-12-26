//
//  QFImageView.swift
//  LAX_aExercise
//
//  Created by 冰凉的枷锁 on 16/8/26.
//  Copyright © 2016年 liuaoxiang. All rights reserved.
//

import UIKit

class QFImageView: UIImageView {
    
    var btn: UIButton!
    var lbl: UILabel!
    
    init(imageName: String, name: String, xx: CGFloat, yy: CGFloat, ww: CGFloat, hh: CGFloat) {
        super.init(image: UIImage.init(named: imageName))
        self.frame = CGRect(x: xx, y: yy, width: ww, height: hh)
        self.isUserInteractionEnabled = true
        createLabel(name: name)
        createButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createLabel(name: String) {
        
        lbl = UILabel.init(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 20))
        lbl.backgroundColor = UIColor.white
        lbl.alpha = 0.5
        lbl.text = name
        lbl.textAlignment = .center
        self.addSubview(lbl)
        
    }
    
    func createButton() {
        
        btn = UIButton.init(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
//        btn.backgroundColor = UIColor.blueColor()
        self.addSubview(btn)
        
    }

}
