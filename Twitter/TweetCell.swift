//
//  TweetCell.swift
//  Twitter
//
//  Created by Lin Zhou on 2/26/17.
//  Copyright © 2017 Lin Zhou. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var tweetLabel: UILabel!
    var tweet: Tweet!{
        didSet{
            tweetLabel.text = tweet.text
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
