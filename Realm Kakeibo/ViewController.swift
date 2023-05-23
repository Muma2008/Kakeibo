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
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        items = readItems()
    }
    override func viewWillAppear(_ animated: Bool) {
        items = readItems()
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        let item: ShoppingItem = items[indexPath.row]
        cell.setCell(title: item.title, price: item.price, isMarked: item.isMarked)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write{
                realm.delete(items[indexPath.row])
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            }
        }
    }
    
    func readItems() -> [ShoppingItem]{
        return Array(realm.objects(ShoppingItem.self))
    }
    
    @IBAction func deleteAllBtn(){
        try! realm.write{
            realm.deleteAll()
        }
        items = readItems()
        tableView.reloadData()
       
    }


}

