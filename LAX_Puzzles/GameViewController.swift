//
//  GameViewController.swift
//  LAX_Puzzles
//
//  Created by 冰凉的枷锁 on 16/8/31.
//  Copyright © 2016年 liuaoxiang. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    //    记录等级 步数 图片大小 空白位置
    var width: CGFloat = 0
    var height: CGFloat = 0
    
    var i = 0
    var b = true
    var step: Int = 0
    
    var imageName = "king2"
    var level: Int = 3
    var size: CGFloat = 0
    
    var location: CGPoint = CGPoint.init(x: 0, y: 0)
    var locationArr: [CGPoint] = []
    var tagArr: [CGPoint] = []
    
    var label: UILabel!
    var backgroundView: UIView!
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.green
        self.navigationItem.title = "拼图游戏"
        
        initialize()
        createUI()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //     创建背景视图
    func initialize() {
        
        //        level = 3
        //        size = 100
        size = 300 / CGFloat(level)
        
        width = UIScreen.main.bounds.size.width
        height = UIScreen.main.bounds.size.height
        
        let xx = CGFloat(level * 2)
        backgroundView = UIView.init(frame: CGRect(x: (width - 300 - xx) / 2, y: 100, width: 300 + xx - 2, height: 300 + xx))
        backgroundView.backgroundColor = UIColor.gray
        self.view.addSubview(backgroundView)
        
        label = UILabel.init()
        label.frame = CGRect(x: (width - 300 - xx) / 2, y: 150 + 300 + xx, width: 100, height: 50)
        label.text = "步数： 0"
        self.view.addSubview(label)
        
        let btn = UIButton.init()
        btn.frame = CGRect(x: (width) / 2, y: 150 + 300 + xx, width: 100, height: 50)
        btn.setTitle("打乱顺序", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(self.btnClick(sender:)), for: .touchUpInside)
        self.view.addSubview(btn)
        
    }
    
    //    创建图片
    func createUI() {
        
        for i in 0...level * level - 1 {
            
            let image = clipImage(image: UIImage.init(named: imageName)!, rect: CGRect(x: CGFloat(i % level) * size, y: CGFloat(i / level) * size, width: size, height: size))
            let imageView = UIImageView.init(image: image)
            imageView.frame = CGRect(x: CGFloat(i % level) * (size + 2), y: CGFloat(i / level) * (size + 2), width: size, height: size)
            
            if i != level * level - 1 {
                imageView.tag = 100 + i
                addTap(imageView: imageView)
                backgroundView.addSubview(imageView)
            }
            
            locationArr.append(imageView.center)
            tagArr.append(imageView.center)
        }
        location = locationArr.last!
        
    }
    
    @objc func btnClick(sender: UIButton) {
        if sender.currentTitle == "打乱顺序" {
            startDisrupt()
            sender.setTitle("停止", for: .normal)
        }
        else {
            timer.invalidate()
            sender.setTitle("打乱顺序", for: .normal)
        }
    }
    
    //    添加点击手势
    func addTap(imageView: UIImageView) {
        
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.tapClick(tap:)))
        imageView.addGestureRecognizer(tap)
        
    }
    
    //    点击手势事件
    @objc func tapClick(tap: UITapGestureRecognizer) {
        
        step += 1
        label.text = "步数：\(step)"
        
        if isMoving(p1: (tap.view?.center)!, p2: location) {
            UIView.animate(withDuration: 0.5, animations: {
                self.startMoving(view: tap.view!)
            })
        }
        
        if isWin() {
            let alertAction1 = UIAlertAction(title: "确定", style: .default) { (ac) in }
            let alert = UIAlertController.init(title: "恭喜你", message: "拼图成功", preferredStyle: .alert)
            alert.addAction(alertAction1)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //    开始移动图片
    func startMoving(view: UIView) {
        let center = view.center
        let index = view.tag - 100
        
//        let space = locationArr.indexOf(location)!
//        guard let space = locationArr.filter({ (point) -> Bool in
//            point == location
//        }).first else { return }
        var space = -1
        for i in 0..<locationArr.count {
            if locationArr[i] == location {
                space = i
                break
            }
        }
        if space == -1 { return }
        
        view.center = location
        view.tag = space + 100
        
        location = center
        swapTagArr(x: index, y: space)
    }
    
    //    记录当前图片的位置
    func swapTagArr(x: Int, y: Int) {
        let t = tagArr[x]
        tagArr[x] = tagArr[y]
        tagArr[y] = t
    }
    
    //    切割图片
    func clipImage(image: UIImage, rect: CGRect) -> UIImage {
        let imageRef = image.cgImage!.cropping(to: rect)
//        let imageRef = CGImageCreateWithImageInRect(image.cgImage!, rect);
        let subImage = UIImage(cgImage: imageRef!)
        return subImage;
    }
    
    //    判断是否移动
    func isMoving(p1: CGPoint, p2: CGPoint) -> Bool {
        if getDistance(x: p1.x, y: p2.x) * getDistance(x: p1.x, y: p2.x) + getDistance(x: p1.y, y: p2.y) * getDistance(x: p1.y, y: p2.y) < (size + 10) * (size + 10) {
            return true
        }
        return false
    }
    
    func getDistance(x: CGFloat, y: CGFloat) -> CGFloat {
        return x > y ? x - y : y - x
    }
//    法2
    func isMoving2(p1: CGPoint, p2: CGPoint) -> Bool {
        return true
    }
    
//    开始打乱顺序
    func startDisrupt() {
        i = 0
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.onTimer(timer:)), userInfo: nil, repeats: true)
        
//        while location != locationArr.last {
//            print(location)
//            disrupt()
//            startMoving(self.view.viewWithTag(locationArr.count - 1 + 100)!)
//            location = locationArr.last!
//        }
    }
    
//    定时器事件
    @objc func onTimer(timer: Timer) {
        
//        i += 1
//        if i > 10000 {
//            timer.invalidate()
//        }
        
        disrupt()
    }
    
//    随机移动
    func disrupt() {
        
        let n = Int(arc4random_uniform(UInt32(locationArr.count))) + 100
        let view = self.view.viewWithTag(n)
        
        if view == nil {
            return
        }
        
        if isMoving(p1: (view?.center)!, p2: location) {
            UIView.animate(withDuration: 0.1, animations: {
                self.startMoving(view: view!)
                }, completion: { (b) in
            })
        }
        
    }
    
    //    判断输赢
    func isWin() -> Bool {
        
        for i in 0...locationArr.count - 2 {
            if locationArr[i] != tagArr[i] {
                return false
            }
        }
        return true
    }
    
}
