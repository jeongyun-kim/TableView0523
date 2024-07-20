//
//  ShoppingViewController.swift
//  TableView0523
//
//  Created by 김정윤 on 7/20/24.
//

import UIKit
import SnapKit

final class ShoppingViewController: UIViewController {
    
    var list: [Shopping] = [Shopping(productName: "오이"), Shopping(productName: "사과")]
    
    enum Section: Int, CaseIterable {
        case main
    }
    
    private lazy var addTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .systemGray6
        textField.placeholder = "무엇을 구매하실건가요?"
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 56))
        textField.leftView = leftView
        textField.leftViewMode = .always
        return textField
    }()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    private var dataSource: UICollectionViewDiffableDataSource<Section, Shopping>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstratins()
        setupUI()
        configureDataSource()
        configureSnapshot()
    }
    
    private func setupHierarchy() {
        view.addSubview(addTextField)
        view.addSubview(collectionView)
    }
    
    private func setupConstratins() {
        addTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.height.equalTo(56)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(addTextField.snp.bottom).offset(12)
            make.horizontalEdges.bottom.equalTo(view)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func layout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    private func configureDataSource() {
        var registration: UICollectionView.CellRegistration<UICollectionViewListCell, Shopping>!
        
        registration = UICollectionView.CellRegistration(handler: { cell, indexPath, item in
            let size: CGFloat = 30
            var content = UIListContentConfiguration.valueCell()
            
            content.text = item.productName
            content.textProperties.font = .systemFont(ofSize: 15)
            
            let image = item.isComplete ? "checkmark.square.fill" : "checkmark.square"
            content.image = UIImage(systemName: image)
            content.imageProperties.maximumSize = CGSize(width: size, height: size)
            content.imageToTextPadding = 16
            
            cell.contentConfiguration = content
        })
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: item)
            return cell 
        })
    }
    
    private func configureSnapshot() {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list, toSection: .main)
        dataSource.apply(snapshot)
    }
    
    private func insertItem(_ newItem: Shopping) {
        var snapshot = dataSource.snapshot()
        if let lastItem = snapshot.itemIdentifiers.last {
            snapshot.insertItems([newItem], afterItem: lastItem)
            dataSource.apply(snapshot)
        }
    }
}

extension ShoppingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 else { return false }
        let newItem = Shopping(productName: text)
        insertItem(newItem)
        textField.text = ""
        return true
    }
}
