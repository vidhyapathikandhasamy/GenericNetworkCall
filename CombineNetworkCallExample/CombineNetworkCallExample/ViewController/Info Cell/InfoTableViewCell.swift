//
//  InfoTableViewCell.swift
//  CombineNetworkCallExample
//
//  Created by Vidhyapathi on 17/11/24.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    //MARK: - Cell Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.containerView.layer.cornerRadius = 10
    }
    
    func upateInfoCell(userList: UserResponseMain) {
        self.nameLabel.text = userList.name
        self.emailLabel.text = userList.email
        self.addressLabel.text = userList.fullAddress
    }
    
}
