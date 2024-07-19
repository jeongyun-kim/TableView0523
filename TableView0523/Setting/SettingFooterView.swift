//
//  SettingFooterView.swift
//  TableView0523
//
//  Created by 김정윤 on 7/19/24.
//

import UIKit
import SnapKit

final class SettingFooterView: BaseHeaderFooterView {
    static var elementKind: String { return UICollectionView.elementKindSectionFooter }
    
    let footerLabel = UILabel()
  
    override func setupHierarchy() {
        addSubview(footerLabel)
    }
    
    override func setupConstraints() {
        footerLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.verticalEdges.equalTo(safeAreaLayoutGuide).inset(8)
        }
    }
    
    override func configureLayout() {
        footerLabel.font = .systemFont(ofSize: 14)
        footerLabel.textColor = .lightGray
        footerLabel.numberOfLines = 0
    }
}
