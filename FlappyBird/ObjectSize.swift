//
//  ObjectSize.swift
//  FlappyBird
//
//  Created by AiTH2 on 2018/12/26.
//  Copyright © 2018 hirohisa.kimura. All rights reserved.
//

import UIKit

struct ObjectSize{
    
    static func bounds()->CGRect{
        return UIScreen.main.bounds;
    }
    static func screenWidth()->Int{
        return Int( UIScreen.main.bounds.size.width);
    }
    static func screenHeight()->Int{
        return Int(UIScreen.main.bounds.size.height);
    }
    
    static func startButtonSize() -> CGSize {
        let w = screenWidth() / 2
        let h = screenHeight() / 12
        return CGSize(width: w, height: h)
    }
    
    static func titleLogoSize() -> CGSize {
        let image = UIImage(named: "title_logo")!
        let aspectScale = image.size.height / image.size.width
        let w: Double = Double(screenWidth()) * 0.8
        let h: Double = Double(w) * Double(aspectScale)
        return CGSize(width: w, height: h)
    }
}
