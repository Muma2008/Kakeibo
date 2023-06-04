//
//  ShoppingItem.swift
//  Realm Kakeibo
//
//  Created by MA on 2023/05/06.
//

import Foundation
import RealmSwift
//リルムに保存するデータ型　persisted＝リルムの鍵
class ShoppingItem: Object{
    @Persisted var title:String = ""
    @Persisted var price:Int = 0
    @Persisted var isMarked:Bool = false
}
