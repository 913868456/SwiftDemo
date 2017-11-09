//
//  ViewController.swift
//  JavaScriptCore_Demo_Swift
//
//  Created by ECHINACOOP1 on 2017/11/8.
//  Copyright © 2017年 蔺国防. All rights reserved.
//

import UIKit
import JavaScriptCore

let kScreenW = UIScreen.main.bounds.size.width
let kScreenH = UIScreen.main.bounds.size.height

@objc protocol SwiftBridgeProtocol: JSExport{
   
    //JS调用本地方法(无参数)
    func method1()
    func method2(_ title: String, _ message: String)
    func method3(_ handlerName: String)
}

@objc class SwiftBrige: NSObject, SwiftBridgeProtocol{
    
    weak var controller: UIViewController?
    weak var context   : JSContext?
    
    //JS调用本地方法(无参数)
    func method1()  {
        
        let controller = UIAlertController.init(title: "测试", message: "JS调用本地方法", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.controller?.present(controller, animated: true, completion: nil)
    }
    
    //JS调用本地方法(传参数)
    func method2(_ title: String, _ message: String) {
        
        let controller = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.controller?.present(controller, animated: true, completion: nil)
    }
    
    //JS调用本地方法  本地方法回调JS方法
    func method3(_ handlerName: String){
        
        //回调参数
        let paraDic = ["name":"小明", "age": 18, "job":"学生"] as [String : Any]
        
        //获取JS回调函数
        let handleFunc = self.context?.objectForKeyedSubscript("\(handlerName)")
        
        //调用该函数
        let _ = handleFunc?.call(withArguments: [paraDic])
        
    }
}

class ViewController: UIViewController, UIWebViewDelegate {
    
    var webView: UIWebView!
    var context: JSContext?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = UIWebView.init(frame: CGRect.init(x: 0, y: 20, width: kScreenW, height: kScreenH - 200))
        webView.delegate = self
        webView.backgroundColor = UIColor.brown
        webView.scalesPageToFit = true
        view.addSubview(webView)
        
        let button = UIButton.init(type: .roundedRect)
        button.frame = CGRect.init(x: kScreenW/2 - 75, y: kScreenH - 170, width: 150, height: 50)
        button.setTitle("本地调用JS方法", for: .normal)
        button.addTarget(self, action: #selector(nativeCallJS), for: .touchUpInside)
        view.addSubview(button)
        
        let URL = Bundle.main.url(forResource: "Test", withExtension: "html")
        
        guard let url = URL else { return }
        
        self.webView.loadRequest(URLRequest.init(url: url))
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        //获取当前JS运行环境
        self.context = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as? JSContext
        
        //判断JSContext是否为空
        guard let ctx = self.context else {
            return
        }
        
        //将模型注入本地html
        self.jsCallNative(ctx)
    }
    
    
    //JS调用本地方法
    func jsCallNative(_ ctx: JSContext) {
        
        //创建桥接模型
        let model = SwiftBrige()
        model.context = ctx
        model.controller = self
        
        //将模型注入JS环境中
        ctx.setObject(model, forKeyedSubscript: "WebViewJSBridge" as NSString)
        
        //将JS写入本地网页
        let url = Bundle.main.url(forResource: "Test", withExtension: "html")
        guard let URL = url else { return  }
        ctx.evaluateScript(try? String.init(contentsOf: URL))
        
        //执行脚本后的错误处理
        ctx.exceptionHandler = {(ctx, exception) in
            
            debugPrint(exception ?? "")
        }
    }
    
    //本地调用JS方法
    @objc func nativeCallJS() {

        //方法一 (直接执行JS脚本)
        let scriptStr = "handler({'name':'小明', 'age':'18','job':'学生'})"
        let _ = self.context?.evaluateScript(scriptStr)
        
        //方法二 (获取函数,然后调用函数传参)
        let handleFunc = self.context?.objectForKeyedSubscript("handler")
        let paraDic = ["name":"小明", "age": 18, "job":"学生"] as [String : Any]
        let _ = handleFunc?.call(withArguments: [paraDic])

    }

}

