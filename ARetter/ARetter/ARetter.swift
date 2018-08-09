//
//  ARetter.swift
//  ARetter
//
//  Created by IkukoHiraga on 2018/08/09.
//  Copyright © 2018年 Oshima Haruna. All rights reserved.
//

import RealmSwift

class ARetter: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var image = ""
    @objc dynamic var message = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}
