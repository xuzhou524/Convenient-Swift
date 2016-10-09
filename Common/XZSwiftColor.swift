//
//  XZSwiftColor.swift
//  Convenient-Swift-Swift
//
//  Created by gozap on 16/3/2.
//  Copyright © 2016年 xuzhou. All rights reserved.
//

import UIKit

func colorWith255RGB(_ r:CGFloat, g:CGFloat, b:CGFloat) ->UIColor{
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0,alpha: 255)
}

func colorWith255RGB(_ r:CGFloat, g:CGFloat, b:CGFloat ,a:CGFloat) ->UIColor{
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a/255.0)
}

func createImageWithColor(_ color:UIColor) -> UIImage{
    return createImageWithColor(color, size: CGSize(width: 1, height: 1))
}

func createImageWithColor(_ color:UIColor,size:CGSize) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContext(rect.size);
    let context = UIGraphicsGetCurrentContext();
    context?.setFillColor(color.cgColor);
    context?.fill(rect);
    
    let theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage!;
}

class XZSwiftColor: UIColor{
    
    static var navignationColor : UIColor{
        get{
            return colorWith255RGB(235 ,g: 85, b: 90);
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
    static var xzGlay100 : UIColor{
        get{
            return colorWith255RGB(100, g: 100, b: 100);
        }
    }
    
    static var yellow255_194_50 : UIColor{
        get{
            return colorWith255RGB(255, g: 194, b: 50);
        }
    }
    
    
    static var barTintColor : UIColor{
        get{
            return colorWith255RGB(7, g: 37, b: 59);
        }
    }
    static var weekBgColor : UIColor{
        get{
            return colorWith255RGB(215, g: 215, b: 215);
        }
    }
}
