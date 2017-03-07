//
//  ProfileHeaderCell.swift
//  Twitter
//
//  Created by Lin Zhou on 3/6/17.
//  Copyright © 2017 Lin Zhou. All rights reserved.
//

import UIKit

class ProfileHeaderCell: UITableViewCell {


    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var realnameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetCountLabel: UILabel!
    
    var user : User!{
        didSet{
            usernameLabel.text = user.screenname
            realnameLabel.text = user.name
            followingCountLabel.text = "\(user.followingCount!)"
            followerCountLabel.text = "\(user.followersCount!)"
            tweetCountLabel.text = "\(user.tweetCount!)"
            
            profileImageView.setImageWith((user.profileUrl)!)
            profileImageView.layer.cornerRadius = 5
            
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
