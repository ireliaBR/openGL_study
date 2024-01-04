//
//  TriangleController.swift
//  SwiftUI_Triangle
//
//  Created by fdd on 2024/1/4.
//

import Foundation
import GLKit
import SwiftUI

class TriangleController: UIViewController, GLKViewDelegate {
    lazy var glkView = {
        let view = GLKView()
        view.context = EAGLContext(api: .openGLES3)!
        view.drawableDepthFormat = .format24
        view.delegate = self
        EAGLContext.setCurrent(view.context)
        return view
    }()
    
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
        view = glkView
//        view.addSubview(glkView)
//        glkView.frame = view.frame
        triangle.setup()
    }

    func glkView(_ view: GLKView, drawIn rect: CGRect) {
        triangle.draw(Float(view.drawableWidth), Float(view.drawableHeight))
    }
}

struct TriangleView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return TriangleController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
