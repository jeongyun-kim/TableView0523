//
//  SettingTableViewController.swift
//  TableView0523
//
//  Created by 김정윤 on 5/23/24.
//

import UIKit

// (0603) 헤더, 셀 내 아이템들 enum 활용하기
enum SettingOptions: String, CaseIterable {
    case all = "전체 설정" // 0
    case personal = "개인 설정" // 1
    case etc = "기타" // 2
    
    var options: [String] {
        switch self {
        case .all: return ["공지사항", "실험실", "버전 정보"]
        case .personal: return ["개인/보안", "알림", "채팅", "멀티프로필"]
        case .etc: return ["고객센터/도움말"]
        }
    }
}

class SettingTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "설정"
    }
    
    // 섹션 별 헤더 타이틀 세팅
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // 섹션 개수가 3개이므로 0, 1, 2
        // -> allCases[0] = .all
        // -> rawValue = "전체 설정"
        return SettingOptions.allCases[section].rawValue
    }
    
    // 섹션의 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingOptions.allCases.count
    }
    
    // 각 섹션 내 행의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 각 섹션의 헤더뷰 타이틀이 불러오는 옵션들의 개수만큼
        return SettingOptions.allCases[section].options.count
    }
    
    // 셀의 높이 조정
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    // 헤더뷰 타이틀 크기 조정
    // UIView 이용! -> cell처럼 불러오기
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        headerView.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
    }
    
    // 섹션에 따라 셀에 각 다른 데이터 넣기
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell") else { return UITableViewCell() }
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.text = SettingOptions.allCases[indexPath.section].options[indexPath.row]
        return cell
    }
}
