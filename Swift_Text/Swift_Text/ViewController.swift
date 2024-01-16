//
//  ViewController.swift
//  Swift_Text
//
//  Created by fdd on 2024/1/16.
//

import UIKit
import GLKit
import Foundation

class ViewController: UIViewController, GLKViewDelegate {
    
    lazy var glkView = {
        let view = GLKView()
        view.context = EAGLContext(api: .openGLES3)!
        view.drawableDepthFormat = .format24
        view.delegate = self
        EAGLContext.setCurrent(view.context)
        return view
    }()
    
    var text = Text()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = glkView
        let path = Bundle.main.bundlePath + "/"
        text.setup((path as NSString).utf8String)
    }

    func glkView(_ view: GLKView, drawIn rect: CGRect) {
        text.draw(Float(view.drawableWidth), Float(view.drawableHeight))
    }
}

