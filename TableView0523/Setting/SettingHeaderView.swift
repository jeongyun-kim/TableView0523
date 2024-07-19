//
//  SettingHeaderView.swift
//  TableView0523
//
//  Created by 김정윤 on 7/19/24.
//

import UIKit
import SnapKit

final class SettingHeaderView: UICollectionReusableView {
    static var elementKind: String { return UICollectionView.elementKindSectionHeader }
    
    let settingLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupConstraints()
        configureLayout()
    }
    
    private func setupHierarchy() {
        addSubview(settingLabel)
    }
    
    private func setupConstraints() {
        settingLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
        }
    }
    
    private func configureLayout() {
        settingLabel.font = .systemFont(ofSize: 14)
        settingLabel.textColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
