//
//  SetViewController.swift
//  LAX_Puzzles
//
//  Created by 冰凉的枷锁 on 16/8/31.
//  Copyright © 2016年 liuaoxiang. All rights reserved.
//

import UIKit

protocol SetLevelProtocol {
    func setLevel(level: Int, name: String)
}

class SetViewController: UIViewController, PassNameProtocol {
    
    var level: Int = 3
    var name: String = "king2"
    var delegate: SetLevelProtocol?

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置"
        slider.setValue(Float(level), animated: true)
        label.text = "\(level) x \(level)"
    }
    
    
//    传值
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.setLevel(level: Int(slider.value + 0.5), name: name)
    }
    
    func passName(str: String) {
        name = str
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
//    }
//    @IBAction func sliderClick(sender: UISlider) {
        
        sender.setValue(Float(Int(sender.value + 0.5)), animated: true)
        label.text = "\(Int(sender.value)) x \(Int(sender.value))"
        
    }
    
    @IBAction func selectPhoto(_ sender: UIButton) {
//    }
//    @IBAction func selectPicture(sender: UIButton) {
        
        let root = ShowViewController()
        root.delegate = self
        self.navigationController?.pushViewController(root, animated: true)
        
    }
}
