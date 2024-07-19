//
//  Setting.swift
//  TableView0523
//
//  Created by 김정윤 on 7/18/24.
//

import UIKit

struct Setting: Hashable, Identifiable {
    var id = UUID()
    let imageName: String?
    let title: String
    let subTitle: String?
    let tintColor: UIColor?
}

struct SettingList {
    let modeSettingList = [
        Setting(imageName: "moon.fill", title: "방해 금지 모드", subTitle: nil, tintColor: .systemPurple),
        Setting(imageName: "bed.double.fill", title: "수면", subTitle: nil, tintColor: .systemOrange),
        Setting(imageName: "doc.text.fill", title: "업무", subTitle: "09:00 ~ 06:00", tintColor: .systemGreen),
        Setting(imageName: "person.fill", title: "개인 시간", subTitle: nil, tintColor: .tintColor)
    ]
    
    
    let shareSettingList = [
        Setting(imageName: nil, title: "모든 기기에서 공유", subTitle: nil, tintColor: nil)
    ]
}
