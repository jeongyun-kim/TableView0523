//
//  BaseHeaderFooterView.swift
//  TableView0523
//
//  Created by 김정윤 on 7/19/24.
//

import UIKit
import SnapKit

class BaseHeaderFooterView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupConstraints()
        configureLayout()
    }
    
    func setupHierarchy() {
      
    }
    
    func setupConstraints() {

    }
    
    func configureLayout() {

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
