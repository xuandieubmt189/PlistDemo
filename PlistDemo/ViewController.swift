//
//  ViewController.swift
//  PlistDemo
//
//  Created by xuandieu on 5/11/17.
//  Copyright © 2017 xuandieu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let myItemKey = "myItem"
    var myItemValue: String?
    
    @IBOutlet weak var txtValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        
        let documentDirectory = paths[0] as! String
        let path = documentDirectory.appending("mydata.plist")
        
        let fileManager = FileManager.default
        if(!fileManager.fileExists(atPath: path)) {
            if let bundlePath = Bundle.main.path(forResource: "mydata", ofType: "plist") {
                let result = NSMutableDictionary(contentsOfFile: bundlePath)
                print("Bundle File mydata.plist is: -> \(String(describing: result?.description))")
                do {
                    try fileManager.copyItem(atPath: bundlePath, toPath: path)
                } catch {
                    print("Copy failure")
                }
            } else {
                print("file myData.plist not found")
            }
        } else {
            print("File mydata.plist already at path")
        }
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        print("Load mydata.plist is -> \(String(describing: resultDictionary?.description))")
        
        let myDict = NSDictionary(contentsOfFile: path)
        if let dict = myDict {
            myItemValue = dict.object(forKey: myItemKey) as? String
            txtValue.text = myItemValue
        } else {
            print("Load Failure")
        }
    }
}


