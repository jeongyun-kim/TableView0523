//
//  SettingHeaderView.swift
//  TableView0523
//
//  Created by 김정윤 on 7/19/24.
//

import UIKit
import SnapKit

final class SettingHeaderView: BaseHeaderFooterView {
    static var elementKind: String { return UICollectionView.elementKindSectionHeader }
    
    let settingLabel = UILabel()
    
    override func setupHierarchy() {
        addSubview(settingLabel)
    }
    
    override func setupConstraints() {
        settingLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(safeAreaLayoutGuide).inset(8)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
        }
    }
    
    override func configureLayout() {
        settingLabel.font = .systemFont(ofSize: 14)
        settingLabel.textColor = .lightGray
    }
}
