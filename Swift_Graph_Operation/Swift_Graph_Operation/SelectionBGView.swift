//
//  SelectionBGView.swift
//  Swift_Graph_Operation
//
//  Created by fdd on 2024/1/11.
//

import UIKit
import SnapKit

class SelectionBGView: UIView {
    
    let selectView = {
        let view = UIView()
        view.layer.borderColor = UIColor.green.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    weak var delegate: SelectionBGViewDelegate?
    var element: Element
    var previousAngle: CGFloat = 0
    var previousScale: CGFloat = 1
    
    init(element: Element) {
        self.element = element
        super.init(frame: CGRectZero)
        setupView()
        
        selectView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panView(gesture:))))
        selectView.addGestureRecognizer(UIRotationGestureRecognizer(target: self, action: #selector(rotationView(gesture:))))
        selectView.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(scaleView(gesture:))))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(selectView)
        selectView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(element.x)
            make.top.equalToSuperview().inset(element.y)
            make.width.equalTo(element.width)
            make.height.equalTo(element.height)
        }
        selectView.layer.transform = element.transform
    }
    
    @objc func panView(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        // Use the translation to update the position or perform custom logic
        // For example, move a view along with the gesture
//        selectView.center = CGPoint(x: selectView.center.x + translation.x, y: selectView.center.y + translation.y)
        element.transform.m41 += translation.x
        element.transform.m42 += translation.y
        element.convertTransform.m41 += translation.x
        element.convertTransform.m42 -= translation.y
        selectView.layer.transform = element.transform
        delegate?.operationSelectView(element: element)
        // Reset the translation to zero after using it
        gesture.setTranslation(.zero, in: selectView)
    }
    
    @objc func rotationView(gesture: UIRotationGestureRecognizer) {
        if gesture.state == .changed {
            let rotationAngle: CGFloat = gesture.rotation - previousAngle
            element.rotate(angle: rotationAngle, 0, 0, 1)
            selectView.layer.transform = element.transform
            previousAngle = gesture.rotation
            delegate?.operationSelectView(element: element)
        } else if gesture.state == .ended {
            previousAngle = 0
        }
    }
    
    @objc func scaleView(gesture: UIPinchGestureRecognizer) {
        if gesture.state == .changed {
            let scale = gesture.scale - previousScale
            element.scale(sx: 1 + scale, sy: 1 + scale, sz: 1)
            selectView.layer.transform = element.transform
            previousScale = gesture.scale
            delegate?.operationSelectView(element: element)
        } else if gesture.state == .ended {
            previousScale = 1
        }
    }
}

protocol SelectionBGViewDelegate: AnyObject {
    func operationSelectView(element: Element)
}
