//
//  RootViewController.swift
//  LAX_Puzzles
//
//  Created by 冰凉的枷锁 on 16/8/31.
//  Copyright © 2016年 liuaoxiang. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, SetLevelProtocol {
    
    var width: CGFloat!
    var height: CGFloat!
    var b = true
    var num: Int = 3
    var nam: String = "king2"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "主页"

        /***************/
        let view = UIImageView.init(frame: self.view.frame)
        view.image = UIImage.init(named: "map")
        self.view.addSubview(view)
        /******************/
        
        width = self.view.frame.size.width
        height = self.view.frame.size.height
        
        initialize()
        startAnimation()
        
    }
    
    func initialize() {
        let start = UIButton.init()
        start.frame = CGRect(x: 30, y: 250, width: width - 60, height: 50)
        start.backgroundColor = UIColor.white
        start.alpha = 0.8
        start.setTitle("开始游戏", for: .normal)
        start.setTitleColor(UIColor.init(red: 0, green: 187 / 255.0, blue: 237 / 255.0, alpha: 1), for: .normal)
        start.addTarget(self, action: #selector(self.startClick(sender:)), for: .touchUpInside)
        self.view.addSubview(start)
        
        let set = UIButton.init()
        set.frame = CGRect(x: 30, y: 400, width: width - 60, height: 50)
        set.backgroundColor = UIColor.white
        set.alpha = 0.8
        set.setTitle("设置", for: .normal)
        set.setTitleColor(UIColor.init(red: 0, green: 187 / 255.0, blue: 237 / 255.0, alpha: 1), for: .normal)
        set.addTarget(self, action: #selector(self.setClick(sender:)), for: .touchUpInside)
        self.view.addSubview(set)
        
    }
    
    @objc func startClick(sender: UIButton) {
        let root = GameViewController()
        root.level = num
        root.imageName = nam
        self.modalTransitionStyle = .flipHorizontal
        self.navigationController?.pushViewController(root, animated: true)
    }
    
    @objc func setClick(sender: UIButton) {
        let root = SetViewController()
        root.delegate = self
        root.level = num
        self.modalTransitionStyle = .flipHorizontal
        self.navigationController?.pushViewController(root, animated: true)
    }
    
    func setLevel(level: Int, name: String) {
        num = level
        nam = name
    }
    
    //    -----------------开始动画
    func startAnimation() {
        createPlayer()
        fallAnimation()
    }
    
    //    ------------------创建角色
    func createPlayer() {
        let imageView = UIImageView.init()
        imageView.frame = CGRect(x: 100, y: -50, width: 50, height: 50)
        imageView.tag = 100
        imageView.image = UIImage.init(named: "player1.png")
        self.view.addSubview(imageView)
    }
    
    //    ------------------掉落动画
    func fallAnimation() {
        let ball = self.view.viewWithTag(100)
        UIView.animate(withDuration: 2, animations: {
            ball?.center = CGPoint(x: 100, y: self.height - 120)
        }) { (b) in
            if b {
                //                print("over")
                self.runAnimation()
            }
        }
    }
    
    //    -----------奔跑动画
    func runAnimation() {
        
        let imageView = self.view.viewWithTag(100) as! UIImageView
        var arr = [UIImage]()
        for i in 10...12 {
            let name = "player\(i).png"
            arr.append(UIImage.init(named: name)!)
        }
        imageView.animationImages = arr
        imageView.animationDuration = 0.5
        imageView.startAnimating()
        
        _ = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        
    }
    
    //    -----------------
    @objc func onTimer() {
        let imageView = self.view.viewWithTag(100) as! UIImageView
        if imageView.center.x > self.view.frame.size.width - 35 {
            b = false
            var arr = [UIImage]()
            for i in 4...6 {
                let name = "player\(i).png"
                arr.append(UIImage.init(named: name)!)
            }
            imageView.animationImages = arr
            imageView.animationDuration = 0.5
            imageView.startAnimating()
        } else if imageView.center.x < 35 {
            b = true
            var arr = [UIImage]()
            for i in 10...12 {
                let name = "player\(i).png"
                arr.append(UIImage.init(named: name)!)
            }
            imageView.animationImages = arr
            imageView.animationDuration = 0.5
            imageView.startAnimating()
        }
        if b {
            imageView.center.x += 1
        } else {
            imageView.center.x -= 1
        }
    }

}
