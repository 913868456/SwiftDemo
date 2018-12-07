//
//  ViewController.swift
//  Shadow_Demo
//
//  Created by 防神 on 2018/11/1.
//  Copyright © 2018年 吃面多放葱. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testView = UIView()
        testView.frame = CGRect(x: view.bounds.size.width/2 - 50, y: 100, width: 100, height: 100)
        
        testView.layer.cornerRadius = 4
        testView.layer.shadowColor = UIColor.orange.cgColor
        testView.layer.shadowOffset = CGSize(width: 10, height: 10)
        testView.layer.shadowRadius = 6
        testView.layer.shadowOpacity = 0.5
        
        testView.backgroundColor = UIColor.red;
        view.addSubview(testView)
        
        // Do any additional setup after loading the view, typically from a nib.
    }


}

