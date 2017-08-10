//
//  UserInfoCell.swift
//  入门TableView
//
//  Created by celink on 15/8/6.
//  Copyright (c) 2015年 celink. All rights reserved.
//

import UIKit

class UserInfoCell: UITableViewCell {

    
    var userNameLabel : UILabel
    var phoneLabel : UILabel
    var emailLabel : UILabel
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        
        userNameLabel = UILabel.init(frame: CGRect.init(x: 30, y: 0, width: 100, height: 44))
        userNameLabel.backgroundColor=UIColor.clear
        userNameLabel.font=UIFont.systemFont(ofSize: 14)
        
        phoneLabel = UILabel(frame: CGRect.init(x: 120, y: 0, width: 200, height: 20))
        phoneLabel.backgroundColor = UIColor.clear
        phoneLabel.font = UIFont.systemFont(ofSize: 13)
        
        emailLabel = UILabel(frame: CGRect.init(x: 120, y: 20, width: 200, height: 20))
        emailLabel.backgroundColor = UIColor.clear
        emailLabel.font = UIFont.systemFont(ofSize: 12)
        
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(userNameLabel)
        self.contentView.addSubview(phoneLabel)
        self.contentView.addSubview(emailLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(userModel: UserModel?)
    {
        if let model = userModel
        {
            userNameLabel.text = model.userName
            phoneLabel.text = model.phone
            emailLabel.text = model.email
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
