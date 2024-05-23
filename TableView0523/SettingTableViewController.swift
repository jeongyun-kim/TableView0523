//
//  SettingTableViewController.swift
//  TableView0523
//
//  Created by 김정윤 on 5/23/24.
//

import UIKit

class SettingTableViewController: UITableViewController {

    // 섹션 별 헤더에 넣을 타이틀들
    let headerTitles: [String] = ["전체 설정", "개인 설정", "기타"]
    // 셀에 넣을 데이터 list[section][row]
    let list = [["공지사항", "실험실", "버전 정보"], ["개인/보안", "알림", "채팅", "멀티프로필"], ["고객센터/도움말"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "설정"
    }
    
    // 섹션 별 헤더 타이틀 세팅
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitles[section]
    }
    
    // 섹션의 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return headerTitles.count
    }
    
    // 각 섹션 내 행의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list[section].count
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell") else { return UITableViewCell() }
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.text = list[indexPath.section][indexPath.row]
        return cell
        
    }

}
