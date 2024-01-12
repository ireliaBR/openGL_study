//
//  ViewController.swift
//  Swift_Graph_Operation
//
//  Created by fdd on 2024/1/10.
//

import UIKit
import GLKit

class ViewController: GLKViewController {
    
    let context = EAGLContext(api: .openGLES3)!
    var quadrangle = {
        return GraphOperation()
    }()
    
    let rotateMat4 = {
        let transform = CATransform3DMakeTranslation(0, 1000, 0)
//        let transform = CATransform3DMakeRotation(3.14 / 4, 0, 0, 1.0)
        var mat4 = Matrix()
        
        mat4.m11 = Float(transform.m11)
        mat4.m12 = Float(transform.m12)
        mat4.m13 = Float(transform.m13)
        mat4.m14 = Float(transform.m14)
        
        mat4.m21 = Float(transform.m21)
        mat4.m22 = Float(transform.m22)
        mat4.m23 = Float(transform.m23)
        mat4.m24 = Float(transform.m24)
        
        mat4.m31 = Float(transform.m31)
        mat4.m32 = Float(transform.m32)
        mat4.m33 = Float(transform.m33)
        mat4.m34 = Float(transform.m34)
        
        mat4.m41 = Float(transform.m41)
        mat4.m42 = Float(transform.m42)
        mat4.m43 = Float(transform.m43)
        mat4.m44 = Float(transform.m44)
        return mat4
    }()
    
    let element = {
        var element = Element(x: 100, y: 100, width: 100, height: 200)
        element.tranlate(tx: 100, ty: 100, tz: 0)
        element.scale(sx: 1.5, sy: 1.5, sz: 1)
        element.rotate(angle: 3.14 / 4, 0, 0, 1)
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let glkView = self.view as! GLKView
        glkView.context = context
        glkView.drawableDepthFormat = .format24
        EAGLContext.setCurrent(glkView.context)
        quadrangle.setup()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let testView = UIView()
            testView.layer.borderColor = UIColor.red.cgColor
            testView.layer.borderWidth = 4
            testView.backgroundColor = .clear
            self.view.addSubview(testView)
            testView.snp.makeConstraints { make in
                make.width.equalTo(100)
                make.height.equalTo(200)
                make.left.equalTo(100)
                make.top.equalTo(100)
            }
            var transform = CGAffineTransformIdentity
            transform = CGAffineTransformTranslate(transform, 100, 100)
            transform = CGAffineTransformScale(transform, 1.5, 1.5)
            transform = CGAffineTransformRotate(transform, 3.14 / 4)
            testView.transform = transform
            
            let test2View = UIView()
            test2View.layer.borderColor = UIColor.green.cgColor
            test2View.layer.borderWidth = 4
            test2View.backgroundColor = .clear
            self.view.addSubview(test2View)
            test2View.snp.makeConstraints { make in
                make.width.equalTo(100)
                make.height.equalTo(200)
                make.left.equalTo(100)
                make.top.equalTo(100)
            }
        }
    }

    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        quadrangle.draw(Float(view.drawableWidth), Float(view.drawableHeight), element.convertMatrix())
    }
}

