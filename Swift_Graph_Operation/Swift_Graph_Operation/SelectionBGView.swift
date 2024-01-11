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
        view.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.8).cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let selectFrame: CGRect
    
    init(selectFrame: CGRect) {
        self.selectFrame = selectFrame
        super.init(frame: CGRectZero)
    }
    
    func setupView() {
        addSubview(selectView)
        selectView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(CGRectGetMinX(selectFrame))
            make.top.equalToSuperview().inset(CGRectGetMinY(selectFrame))
            make.width.equalTo(CGRectGetWidth(selectFrame))
            make.height.equalTo(CGRectGetHeight(selectFrame))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
