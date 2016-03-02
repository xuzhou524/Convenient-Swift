//
//  XZSwiftColor.swift
//  Convenient-Swift-Swift
//
//  Created by gozap on 16/3/2.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit
func colorWith255RGB(r:CGFloat, g:CGFloat, b:CGFloat) ->UIColor{
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0,alpha: 255)
}
func colorWith255RGB(r:CGFloat, g:CGFloat, b:CGFloat ,a:CGFloat) ->UIColor{
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a/255.0)
}
func createImageWithColor(color:UIColor) -> UIImage{
    return createImageWithColor(color, size: CGSizeMake(1, 1))
}
func createImageWithColor(color:UIColor,size:CGSize) -> UIImage {
    let rect = CGRectMake(0, 0, size.width, size.height)
    UIGraphicsBeginImageContext(rect.size);
    let context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    let theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

class XZSwiftColor: NSObject{
   static var convenientBackgroundColor : UIColor{
        get{
            return colorWith255RGB(242, g: 243, b: 245);
        }
    }
    
}
