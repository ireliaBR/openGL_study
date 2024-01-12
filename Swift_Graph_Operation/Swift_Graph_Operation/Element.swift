//
//  Element.swift
//  Swift_Graph_Operation
//
//  Created by fdd on 2024/1/11.
//

import Foundation
import UIKit

struct Element {
    
    var x: CGFloat
    var y: CGFloat
    var width: CGFloat
    var height: CGFloat
    
    var transform: CATransform3D = CATransform3DIdentity
    
    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
    
    mutating func scale(sx: CGFloat, sy: CGFloat, sz: CGFloat) {
        transform = CATransform3DScale(transform, sx, sy, sz)
    }
    
    mutating func tranlate(tx: CGFloat, ty: CGFloat, tz: CGFloat) {
        transform = CATransform3DTranslate(transform, tx, -ty, tz)
    }
    
    mutating func rotate(angle: CGFloat, _ x: CGFloat, _ y: CGFloat, _ z: CGFloat) {
        transform = CATransform3DRotate(transform, angle, x, y, -z)
    }
    
    func convertMatrix() -> ConvertElement {
        let scale = UIScreen.main.scale
        var element = ConvertElement()
        element.x = Float(x * scale)
        element.y = Float(y * scale)
        element.width = Float(width * scale)
        element.height = Float(height * scale)
        element.transform = glm.mat4()
        element.transform[0][0] = Float(transform.m11)
        element.transform[0][1] = Float(transform.m12)
        element.transform[0][2] = Float(transform.m13)
        element.transform[0][3] = Float(transform.m14)
        
        element.transform[1][0] = Float(transform.m21)
        element.transform[1][1] = Float(transform.m22)
        element.transform[1][2] = Float(transform.m23)
        element.transform[1][3] = Float(transform.m24)
        
        element.transform[2][0] = Float(transform.m31)
        element.transform[2][1] = Float(transform.m32)
        element.transform[2][2] = Float(transform.m33)
        element.transform[2][3] = Float(transform.m34)
        
        element.transform[3][0] = Float(transform.m41 * scale)
        element.transform[3][1] = Float(transform.m42 * scale)
        element.transform[3][2] = Float(transform.m43 * scale)
        element.transform[3][3] = Float(transform.m44)
        return element
    }
}
