//
//  FriendsCell.swift
//  Course2
//
//  Created by N!kS on 09.12.2020.
//

import UIKit
import Kingfisher

class FriendsCell: UITableViewCell {

    @IBOutlet weak var friendID: UILabel!
    @IBOutlet weak var friendAvatar: AvatarView!
    private var myFriendVC = MyFriendsTableViewController()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        friendID.text = ""
        friendAvatar.image = nil
    }
    
    
    func configure(with friend: RealmFriend){
        let url = URL(string:friend.icon)
        self.friendAvatar.photoImage.kf.setImage(with: url)
        let firstName = friend.firstName
        let lastName = friend.lastName
        self.friendID.text = "\(firstName) \(lastName)"
    }
    

}
