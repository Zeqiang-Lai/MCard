//
//  UserSetting.swift
//  MCard
//
//  Created by Zeqiang on 2018/7/23.
//  Copyright © 2018年 Zeqiang. All rights reserved.
//

import Foundation

final class UserSetting {
    static let standard = UserSetting()
    
    private init() {}
    
    var userWordBookUrl: URL? {
        return UserDefaults.standard.url(forKey: Keys.userWordBookUrlKey)
    }
}
extension UserSetting {
    enum Keys {
        static let userWordBookUrlKey = "userWordBookUrl"
    }
}
