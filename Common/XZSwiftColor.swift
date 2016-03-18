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

class XZSwiftColor: UIColor{
    
    static var navignationColor : UIColor{
        get{
            return colorWith255RGB(252 ,g: 77, b: 84);
        }
    }
    
    static var textColor : UIColor{
        get{
            return colorWith255RGB(142 ,g: 103, b: 118);
        }
    }

    static var convenientBackgroundColor : UIColor{
        get{
            return colorWith255RGB(245, g: 245, b: 245);
        }
    }
    
    static var xzGlay230 : UIColor{
        get{
            return colorWith255RGB(230, g: 230, b: 230);
        }
    }
    static var xzGlay142 : UIColor{
        get{
            return colorWith255RGB(142, g: 142, b: 142);
        }
    }
    
    static var yellow255_194_50 : UIColor{
        get{
            return colorWith255RGB(255, g: 194, b: 50);
        }
    }
}
