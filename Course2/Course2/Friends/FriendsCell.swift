//
//  FriendsCell.swift
//  Course2
//
//  Created by N!kS on 09.12.2020.
//

import UIKit

class FriendsCell: UITableViewCell {

    @IBOutlet weak var friendID: UILabel!
    @IBOutlet weak var friendAvatar: AvatarView!
    private var myFriendVC = MyFriendsTableViewController()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        friendID.text = ""
        friendAvatar.image = nil
    }
    

}
