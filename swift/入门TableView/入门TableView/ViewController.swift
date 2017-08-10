//
//  ViewController.swift
//  入门TableView
//
//  Created by celink on 15/8/6.
//  Copyright (c) 2015年 celink. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var dataSource = NSMutableArray()
    var currentIndexPath: NSIndexPath?
    var myTableView = UITableView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        for index in 0...12
        {
            let model = UserModel(userName: "name:\(index+1)", userID: index, phone: "1304813042", email: "1425252@qq.com")
            dataSource.add(model)
        }
        
        myTableView = UITableView(frame: self.view.bounds)
        myTableView.delegate = self
        myTableView.dataSource = self
        self.view.addSubview(myTableView)
        self.title="UITableViewDemo"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UserInfoCell? = tableView.dequeueReusableCell(withIdentifier: "cell") as? UserInfoCell
        
        if cell == nil
        {
            cell=UserInfoCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        }
        
        let model: UserModel? = dataSource[indexPath.row] as? UserModel
        cell?.configureCell(userModel: model)
        
        return cell!
    }
    
    
    
    
}

