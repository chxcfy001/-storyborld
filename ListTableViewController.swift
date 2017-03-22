//
//  ListTableViewController.swift
//  私人通讯录storyborld
//
//  Created by WorldShow'sMac on 2017/3/17.
//  Copyright © 2017年 WorldShow'sMac. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    var listData = [detailModel]()
   
    

    override func viewDidLoad() {
        super.viewDidLoad()

        getData { (dataList) in
            self.listData += dataList
            print("reloadData")
            self.tableView.reloadData()
            }
        }

    
    private func getData(backlist:@escaping ([detailModel]) -> ()) -> () {
    DispatchQueue.global().async {
        Thread.sleep(forTimeInterval: 2)
        var list = [detailModel]()
        for i in 0..<10{
            let Model = detailModel()
            Model.name = "liming\(i)"
            Model.telPhone = "139"+String(format: "%08d", String(arc4random_uniform(10000000)))
            Model.title = "thisIsAtest\(i)"
            list.append(Model)
        }
        DispatchQueue.main.async {
            backlist(list)
        }
    }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
 
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let model = listData[indexPath.row]
        cell.textLabel?.text = model.name
        cell.detailTextLabel?.text = model.telPhone
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "listTocontorller", sender: indexPath)
    }
    

    //storyboard跳转方法 调用performSugue 然后在调用prepare（可以在此处传递参数以及完成回调的操作）
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! detailTableViewController
        if let indexpath = sender as? IndexPath { //所有的let guard中的 as一律使用？(！为一定有值，不需要if)
            vc.person = listData[indexpath.row]
            vc.blockBack = {
                self.tableView.reloadRows(at: [indexpath], with: .automatic)
            }
        }else{
            vc.blockBack = {
                guard let _ = vc.person else {
                    return
                } // 直接通过持有下一个页面的属性 不需要在闭包中额外写入参数
                let p = vc.person//
                self.listData.insert(p!, at: 0)
                self.tableView.reloadData()
            }
           
        }
     
    }

    @IBAction func addNewDetail(_ sender: Any) {
        performSegue(withIdentifier: "listTocontorller", sender: nil)
    }
}
