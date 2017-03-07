//
//  ProfileTweetCell.swift
//  Twitter
//
//  Created by Lin Zhou on 3/6/17.
//  Copyright © 2017 Lin Zhou. All rights reserved.
//

import UIKit

class ProfileTweetCell: UITableViewCell {

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func reply(_ sender: Any) {
    }
    
    @IBAction func favorite(_ sender: Any) {
    }
    
    @IBAction func retweet(_ sender: Any) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
