//
//  ViewController.swift
//  Swift_Graph_Operation
//
//  Created by fdd on 2024/1/10.
//

import UIKit
import GLKit
import SnapKit

class ViewController: GLKViewController {
    
    let context = EAGLContext(api: .openGLES3)!
    var quadrangle = {
        return GraphOperation()
    }()
    
    var element = {
        var element = Element(x: 100, y: 100, width: 100, height: 200)
        element.tranlate(tx: 100, ty: 100, tz: 0)
        element.scale(sx: 1.5, sy: 1.5, sz: 1)
        element.rotate(angle: 3.14 / 4, 0, 0, 1)
        return element
    }()
    
    lazy var selectBGView = {
        let view = SelectionBGView(element: self.element)
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let glkView = self.view as! GLKView
        glkView.context = context
        glkView.drawableDepthFormat = .format24
        EAGLContext.setCurrent(glkView.context)
        quadrangle.setup()
        
        view.addSubview(selectBGView)
        selectBGView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        quadrangle.draw(Float(view.drawableWidth), Float(view.drawableHeight), element.convertMatrix())
    }
}

extension ViewController: SelectionBGViewDelegate {
    func operationSelectView(element: Element) {
        self.element = element
    }
}

