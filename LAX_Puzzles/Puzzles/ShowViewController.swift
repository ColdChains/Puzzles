//
//  ShowViewController.swift
//  LAX_Puzzles
//
//  Created by 冰凉的枷锁 on 16/9/1.
//  Copyright © 2016年 liuaoxiang. All rights reserved.
//

import UIKit

protocol PassNameProtocol {
    func passName(str: String)
}

class ShowViewController: UIViewController{

    var tag: Int = -1
    var delegate: PassNameProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.green
        self.navigationItem.title = "选择图片"
        createItem()
        createUI()
        
    }
    
//    创建菜单项
    func createItem() {
        let btn = UIButton.init()
        btn.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        btn.setTitle("保存", for: .normal)
//        btn.backgroundColor = UIColor.green
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.addTarget(self, action: #selector(self.saveClick), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: btn)
    }
    
//    创建图片
    func createUI() {
        
        let names = getImageNameArray()
        let width = (self.view.frame.size.width - 8) / 4
//        let height = width / 7 * 10
//        print(names)
        for i in 0...names.count - 1 {
            
            let name = names[i]
            let image = QFImageView.init(imageName: name, name: name, xx: (width + 2) * (CGFloat(i % 4)) + 1, yy: 100 + (width + 2) * CGFloat(i / 4), ww: width, hh: width)
//            let image = QFImageView.init(imageName: name, name: name, xx: (width + 2) * (CGFloat(i) % 4) + 1, yy: 100 + (width + 2) * CGFloat(i / 4), ww: width, hh: width)
            image.tag = 100 + i
            image.btn.tag = 10 + i
            image.btn.addTarget(self, action: #selector(self.btnClick(sender:)), for: .touchUpInside)
            self.view.addSubview(image)
//            print(image.frame)
        }
        
    }
    
//    保存事件
    @objc func saveClick(sender: UIButton) {
        if tag < 0 {
            return
        }
        let arr = getImageNameArray()
        delegate?.passName(str: arr[tag])
        self.navigationController?.popViewController(animated: true)
    }
    
//    点击事件
    @objc func btnClick(sender: UIButton) {
        
        if tag >= 0 {
            let view = self.view.viewWithTag(tag + 200)
            view!.removeFromSuperview()
        }
        
        tag = sender.tag - 10
        let image = self.view.viewWithTag(sender.tag + 90) as! QFImageView
        let view = UIView.init(frame: image.frame)
        view.backgroundColor = UIColor.blue
        view.tag = 200 + tag
        view.alpha = 0.3
        self.view.addSubview(view)
    }
    
//    获取图片名称
    func getImageNameArray() -> Array<String> {
        
        var names = [String]()
        guard let path = Bundle.main.path(forResource: "AlbumData", ofType: "plist") else {
            return names
        }
//        let path = "/Users/qianfeng/Desktop/Swift_UIKit/LAX/PROJECT/LAX_Puzzles/LAX_Puzzles/images/AlbumData.plist"
        let arr = NSArray.init(contentsOfFile: path)
        for i in arr! {
            let name = (i as! NSDictionary).object(forKey: "name") as! String
            names.append(name)
        }
        return names
    }
    
}
