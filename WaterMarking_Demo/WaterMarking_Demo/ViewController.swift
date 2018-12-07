//
//  ViewController.swift
//  WaterMarking_Demo
//
//  Created by 防神 on 2018/11/5.
//  Copyright © 2018年 吃面多放葱. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageOne = UIImage(named: "IMG_1193.JPG", in: nil, compatibleWith: nil);
        
        let imageTwo = UIImage.waterMarkingImage(image: imageOne!, with: "2018.01.15")
        let imageThree = UIImage.waterMarkingImage(image: imageTwo!, with: UIImage(named: "watermark")!)
        let imageViewOne = UIImageView(frame: CGRect(x: 20, y: 100, width: UIScreen.main.bounds.size.width/2 - 30, height: 400))
        imageViewOne.image = imageOne
        let imageViewTwo = UIImageView(frame: view.bounds)
        imageViewTwo.contentMode = .scaleAspectFit
        imageViewTwo.image = imageThree
//        view.addSubview(imageViewOne)
        view.addSubview(imageViewTwo)
        
        // Do any additional setup after loading the view, typically from a nib.
    }


}

extension UIImage {
    
    /// Add WaterMarkingImage
    ///
    /// - Parameters:
    ///   - image: the image that painted on
    ///   - waterImageName: waterImage
    /// - Returns: the warterMarked image
    static func waterMarkingImage(image : UIImage, with waterImage: UIImage) -> UIImage?{
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, 0)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        let waterImageX = image.size.width * 0.78
        let waterImageY = image.size.height - image.size.width / 5.4
        let waterImageW = image.size.width * 0.2
        let waterImageH = image.size.width * 0.075
        waterImage.draw(in: CGRect(x: waterImageX, y: waterImageY, width: waterImageW, height: waterImageH))
        
        let waterMarkingImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return waterMarkingImage
    }
    
    /// Add WaterMarking Text
    ///
    /// - Parameters:
    ///   - image: the image that painted on
    ///   - text: the text that needs painted
    /// - Returns: the waterMarked image
    static func waterMarkingImage(image : UIImage, with text: String) -> UIImage?{
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, 0)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        let str = text as NSString
        let pointY = image.size.height - image.size.width * 0.1
        let point = CGPoint(x: image.size.width * 0.78, y: pointY)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.8),
                        NSAttributedString.Key.font           : UIFont.systemFont(ofSize: image.size.width / 25.0)
                        ] as [NSAttributedString.Key : Any]
        str.draw(at: point, withAttributes: attributes)
        
        let waterMarkingImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return waterMarkingImage
    }
}


