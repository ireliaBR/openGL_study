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
    
    var element: Element
    
    init(element: Element) {
        self.element = element
        super.init(frame: CGRectZero)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
