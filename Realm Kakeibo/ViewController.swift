//
//  ViewController.swift
//  Realm Kakeibo
//
//  Created by MA on 2023/05/06.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    let realm = try! Realm()
    var items: [ShoppingItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let content = UNMutableNotificationContent()
        content.title = "いやっふぅ"
        content.body = "ちびいやっふぅ"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        items = readItems()
    }
  //画面が開かれたのと同時にデータと表示を更新する
    override func viewWillAppear(_ animated: Bool) {
        items = readItems()
        tableView.reloadData()
    }
    
    //横スライドによる削除機能
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write{
                realm.delete(items[indexPath.row])//触られたセル（のリルムデータ）を消す
                items = readItems()//リルムデータの更新
                tableView.deleteRows(at: [indexPath], with: .fade)//画面上押されたセルを消す
            }
        }
//        items = readItems() ←important point!!
        tableView.reloadData()
    }
    //画面上のセルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    //セルの中身(表示も）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        let item: ShoppingItem = items[indexPath.row]
        cell.setCell(title: item.title, price: item.price, isMarked: item.isMarked)
        return cell
    }
    
    //
    func readItems() -> [ShoppingItem]{
        return Array(realm.objects(ShoppingItem.self))
    }
    //セルとリルム全消しボタン
    @IBAction func deleteAllBtn(){
        try! realm.write{
            realm.deleteAll()
        }
        items = readItems()
        tableView.reloadData()
    }

}


