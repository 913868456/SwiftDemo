//
//  ViewController.swift
//  PasteBoard_Demo
//
//  Created by 防神 on 2018/11/28.
//  Copyright © 2018年 吃面多放葱. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //注册APP进入前台通知,刷新列表数据
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground(_:)),
                                               name: UIApplication.willEnterForegroundNotification, object: nil);
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func applicationWillEnterForeground(_ notification: Notification) {
        
        if UIPasteboard.general.hasStrings{
            if let pasteStr = UIPasteboard.general.string, pasteStr.count == 6 {
                print(pasteStr);
            }
        }
    }

}

