//
//  NewItemViewController.swift
//  Realm Kakeibo
//
//  Created by MA on 2023/05/06.
//

import UIKit
import RealmSwift
class NewItemViewController: UIViewController {
    let realm = try! Realm()
    @IBOutlet var titleTextField:UITextField!
    @IBOutlet var priceTextField:UITextField!
    @IBOutlet var markSwitch:UISwitch!
    @IBOutlet var Btn:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        Btn.isEnabled = false

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveBtn(){
        let item = ShoppingItem() // 新しいデータの塊を作る
        item.title = titleTextField.text ?? ""
        item.price = Int(priceTextField.text ?? "") ?? 0
        item.isMarked = markSwitch.isOn
        creatItem(item: item)
        self.dismiss(animated: true)
    }

    func creatItem(item: ShoppingItem){
            try! realm.write{
                realm.add(item)
            }
    }
    
    @IBAction func checkBtn(){
        if titleTextField.text == "" || priceTextField.text == ""{
            Btn.isEnabled = false
        }else{
            Btn.isEnabled = true
            // mutton
        }
    }
}
