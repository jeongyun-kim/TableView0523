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
        case mode
        case share
        
        var header: String {
            switch self {
            case .mode:
                return "모드 설정"
            case .share:
                return ""
            }
        }
        
        var footer: String {
            switch self {
            case .mode:
                return "집중 모드에서는 경고 및 알림 소리가 울리지 않습니다."
            case .share:
                return "이 기기에서 집중 모드를 켜면 사용자의 다른 기기에서도 집중 모드가 켜집니다."
            }
        }
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
        configureHeaderFooterView()
        updateSnapshot()
    }
    
    private func setupHierarchy() {
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "집중 모드"
        let rightItem = UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: self, action: #selector(rightBtnTapped))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc private func rightBtnTapped(_ sender: UIButton) {
        let vc = ShoppingViewController()
        navigationController?.pushViewController(vc, animated: true)
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
    
    private func configureHeaderFooterView() {
        var headerRegistration: UICollectionView.SupplementaryRegistration<SettingHeaderView>!
        
        headerRegistration = UICollectionView.SupplementaryRegistration(elementKind: SettingHeaderView.elementKind, handler: { [weak self] supplementaryView, elementKind, indexPath in
            guard let self else { return }
            let headerTitle = self.dataSource.snapshot().sectionIdentifiers[indexPath.section].header
            supplementaryView.settingLabel.text = headerTitle
        })
        
        var footerRegistration: UICollectionView.SupplementaryRegistration<SettingFooterView>!
        
        footerRegistration = UICollectionView.SupplementaryRegistration(elementKind: SettingFooterView.elementKind, handler: { [weak self] supplementaryView, elementKind, indexPath in
            guard let self else { return }
            let footerTitle = self.dataSource.snapshot().sectionIdentifiers[indexPath.section].footer
            supplementaryView.footerLabel.text = footerTitle
        })
        
        dataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            if elementKind == SettingHeaderView.elementKind {
                return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
            } else {
                return collectionView.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: indexPath)
            }
        }
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
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        // 헤더 모드 설정
        config.headerMode = .supplementary
        // 헤더 상단 여백
        config.headerTopPadding = 5
        // 푸터 모드 설정
        config.footerMode = .supplementary
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
}

