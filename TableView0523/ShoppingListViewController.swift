//
//  ShoppingListViewController.swift
//  TableView0523
//
//  Created by 김정윤 on 5/23/24.
//

import UIKit

class ShoppingListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var items: [String] = []
    
    @IBOutlet var addView: UIView!
    @IBOutlet var addBtn: UIButton!
    @IBOutlet var addTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupUI() {
        addTextField.borderStyle = .none
        addTextField.attributedPlaceholder = NSAttributedString(string: "무엇을 구매하실건가요?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        addTextField.backgroundColor = .systemGray6
        addTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        addTextField.leftViewMode = .always
        
        addBtn.setTitle("추가", for: .normal)
        addBtn.tintColor = .black
        addBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        addBtn.layer.backgroundColor = UIColor.systemGray5.cgColor
        addBtn.layer.cornerRadius = 8
        
        addView.layer.cornerRadius = 10
        addView.backgroundColor = .systemGray6
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func addBtnTapped(_ sender: Any) {
        guard let item = addTextField.text else { return }
        items.append(item)
        tableView.reloadData()
        view.endEditing(true)
    }
}

extension ShoppingListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension ShoppingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") else { return UITableViewCell()}
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.backgroundColor = .systemGray6
        //cell.backgroundView?.layer.cornerRadius = 10
        cell.layer.cornerRadius = 10
        return cell
    }
}
