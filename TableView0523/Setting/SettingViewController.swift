//
//  SettingViewController.swift
//  TableView0523
//
//  Created by 김정윤 on 7/18/24.
//

import UIKit
import SnapKit

final class SettingViewController: UIViewController {
    
    enum Section: String, CaseIterable {
        case mode = "모드 설정"
        case share = ""
    }
    
    private let list = SettingList()
    var dataSource: UICollectionViewDiffableDataSource<Section, Setting>!
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupUI()
        configureDataSource()
        updateSnapshot()
    }
    
    private func setupHierarchy() {
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureDataSource() {
        var registration: UICollectionView.CellRegistration<UICollectionViewListCell, Setting>!
        
        // 여기서 셀 구성
        registration = UICollectionView.CellRegistration(handler: { cell, indexPath, item in
            let imageSize = 25
            
            // 구조체니까 var
            var content = UIListContentConfiguration.sidebarSubtitleCell()
            content.text = item.title
            content.textProperties.font = .systemFont(ofSize: 14)
            content.secondaryText = item.subTitle
            if let imageName = item.imageName, let tintColor = item.tintColor {
                content.image = UIImage(systemName: imageName)
                content.imageProperties.maximumSize = CGSize(width: imageSize, height: imageSize)
                content.imageProperties.tintColor = tintColor
            }
            cell.contentConfiguration = content
            cell.accessories = [.disclosureIndicator()]
        })
        
        // 셀 꺼내와 그려주기
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: item)
            return cell
        })
    }
    
    private func updateSnapshot() {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list.modeSettingList, toSection: .mode)
        snapshot.appendItems(list.shareSettingList, toSection: .share)
        dataSource.apply(snapshot)
    }
    
    private func layout() -> UICollectionViewLayout {
        // 시스템 셀 등록
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
}

