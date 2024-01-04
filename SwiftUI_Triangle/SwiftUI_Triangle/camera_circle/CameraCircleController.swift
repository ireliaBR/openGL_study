//
//  CameraCircleController.swift
//  SwiftUI_Triangle
//
//  Created by fdd on 2024/1/4.
//

import Foundation
import GLKit
import SwiftUI

class CameraCircleController: UIViewController, GLKViewDelegate {
    lazy var glkView = {
        let view = GLKView()
        view.context = EAGLContext(api: .openGLES3)!
        view.drawableDepthFormat = .format24
        view.delegate = self
        EAGLContext.setCurrent(view.context)
        return view
    }()
    
    var cameraCircle = {
        let path = Bundle.main.bundlePath + "/"
        return CameraCircle((path as NSString).utf8String)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = glkView
        cameraCircle.setup()
    }

    func glkView(_ view: GLKView, drawIn rect: CGRect) {
        cameraCircle.draw(Float(view.drawableWidth), Float(view.drawableHeight), CACurrentMediaTime())
    }
}

struct CameraCircleView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return CameraCircleController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
