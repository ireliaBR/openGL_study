//
//  ViewController.swift
//  Swift_CPP_Triangle
//
//  Created by fdd on 2024/1/4.
//

import UIKit
import GLKit

class ViewController: GLKViewController {
    
    let context = EAGLContext(api: .openGLES3)!
    var triangle = {
        var vertices: [Float] = [
            0.0,  0.5, 0.0,
           -0.5, -0.5, 0.0,
            0.5, -0.5, 0.0
        ]
        return Triangle(&vertices, Int32(MemoryLayout<Float>.size * vertices.count))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let glkView = self.view as! GLKView
        glkView.context = context
        glkView.drawableDepthFormat = .format24
        EAGLContext.setCurrent(glkView.context)
        triangle.setup()
    }

    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        triangle.draw(Float(view.drawableWidth), Float(view.drawableHeight))
    }
}

