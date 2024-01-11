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
        
        element.transform[3][0] = Float(transform.m41)
        element.transform[3][1] = Float(transform.m42)
        element.transform[3][2] = Float(transform.m43)
        element.transform[3][3] = Float(transform.m44)
        return element
    }
}
