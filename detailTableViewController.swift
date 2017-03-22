//
//  detailTableViewController.swift
//  私人通讯录storyborld
//
//  Created by WorldShow'sMac on 2017/3/17.
//  Copyright © 2017年 WorldShow'sMac. All rights reserved.
//

import UIKit

class detailTableViewController: UITableViewController,UITextFieldDelegate {
    
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var phoneTf: UITextField!
    @IBOutlet weak var titleTf: UITextField!
    
    var person : detailModel?
    var blockBack:(()->())?


    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        if person != nil {
            nameTf.text = person?.name
            phoneTf.text = person?.telPhone
            titleTf.text = person?.title
        }
        
        nameTf.addTarget(self, action: #selector(textfildDidChange(textfile:)), for: .editingChanged)
        phoneTf.addTarget(self, action: #selector(textfildDidChange(textfile:)), for: .editingChanged)
        titleTf.addTarget(self, action: #selector(textfildDidChange(textfile:)), for: .editingChanged)

    }

    func textfildDidChange(textfile:UITextField) -> () {
        var maxCount = 0
        switch textfile {
        case nameTf:
            maxCount = 5
        case phoneTf,titleTf:
            maxCount = 11
        default:
            maxCount = 0
        }
        if (textfile.text?.characters.count)! > maxCount {
            var lengthStr = ""
            for _ in 0..<maxCount {
                lengthStr += "a"
            }
            textfile.text = textfile.text?.substring(to: lengthStr.endIndex)
        }
    }


    @IBAction func saveDataAction(_ sender: Any) {
        print(nameTf.text ?? "",phoneTf.text ?? "",titleTf.text ?? "")
        if person == nil {
            person = detailModel()
        }
        person?.title = titleTf.text
        person?.telPhone = phoneTf.text
        person?.name = nameTf.text
        blockBack?()
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        resinerTextF()
    }
    
    private func resinerTextF(){
        nameTf.resignFirstResponder()
        phoneTf.resignFirstResponder()
        titleTf.resignFirstResponder()
    
    }
    
    deinit {
//        phoneTf.removeTarget(self, action: #selector(textfildDidChange(textfile:)), for: .editingChanged)
        print("deinitSuccess")
    }

}
