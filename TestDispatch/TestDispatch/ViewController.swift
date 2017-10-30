//
//  ViewController.swift
//  TestDispatch
//
//  Created by ECHINACOOP1 on 2017/10/26.
//  Copyright © 2017年 蔺国防. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        串行队列同步执行 当前线程,一个一个执行, 在一个线程中尝试同步执行队列中任务会导致死锁.
//        test1()
//        串行队列异步执行 其他线程,一个一个执行
//        test2()
//        并行队列同步执行 当前线程,一个一个执行
//        test3()
//        并行队列异步执行 多个线程,一起执行
//        test4()
    }
    
    func test1() {
        
        let queue1 = DispatchQueue.init(label: "com.gxyj.serial")
        print(print("前:", Thread.current, Thread.main))
        
        for i in 0...10{
            
            queue1.sync {
                print("index\(i)", Thread.current, Thread.main)
            }
        }
        
        print(print("后:", Thread.current, Thread.main))
    }
    
    func test2() {
        let queue1 = DispatchQueue.init(label: "com.gxyj.serial")
        print(print("前:", Thread.current, Thread.main))
        
        for i in 0...10{
            
            queue1.async {
                print("index---\(i)", Thread.current, Thread.main)
            }
        }
         print(print("后:", Thread.current, Thread.main))
    }
    
    func test3() {
        let queue1 = DispatchQueue.init(label: "com.gxyj.concurrent", attributes: .concurrent)
        print(print("前:", Thread.current, Thread.main))
        
        for i in 0...10{
            
            queue1.sync {
                print("index---\(i)", Thread.current, Thread.main)
            }
        }
         print(print("后:", Thread.current, Thread.main))
    }
    
    func test4()  {
        
        let queue1 = DispatchQueue.init(label: "com.gxyj.concurrent", attributes: .concurrent)
        print(print("前:", Thread.current, Thread.main))
        for i in 0...10{
            
            queue1.async {
                print("index---\(i)", Thread.current, Thread.main)
            }
        }
         print(print("后:", Thread.current, Thread.main))
    }
}

