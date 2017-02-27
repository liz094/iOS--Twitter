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
    
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var tweetCountLabel: UILabel!
    
       var tweet: Tweet!{
        didSet{
            tweetLabel.text = tweet.text
            profileImageView.setImageWith((tweet.user?.profileUrl)!)
            profileImageView.layer.cornerRadius = 5
            userNameLabel.text = tweet.user?.name
            //favoriteButton.imageView?.image = UIImage(named:"favor-icon.png")
            favoriteCountLabel.text = String(tweet.favoritesCount)
            
            tweetCountLabel.text = String(tweet.retweetCount)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM dd, yyyy 'at' h:mm aaa"
            self.timeStampLabel.text = formatter.string(from: tweet.timestamp!)

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
    
    @IBAction func onFavorite(_ sender: UIButton) {
        let button = sender
        
        TwitterClient.sharedInstance?.favorite(tweetID: tweet.tweetID, favorite: tweet.favorited, completion: { (tweet, error) -> (Void) in
            if(error==nil){
                button.imageView?.image = UIImage(named:"favor-icon-red.png")
            }
        })
        
        if(sender.isSelected){
            //deselect
            sender.isSelected = false
            tweet.favorited = false
            favoriteCountLabel.text = String(tweet.favoritesCount)
            button.imageView?.image = UIImage(named:"favor-icon.png")
            
        }
        else{
            //select
            sender.isSelected = true
            tweet.favorited = true
            favoriteCountLabel.text = String(tweet.favoritesCount)
            button.imageView?.image = UIImage(named:"favor-icon-red.png")

        }
        
    }
    
    @IBAction func onRetweet(_ sender: UIButton) {
        let button = sender
        if(sender.isSelected){
            //deselect
            sender.isSelected = false
            tweet.retweeted = false
            tweetCountLabel.text = String(tweet.retweetCount)
            button.imageView?.image = UIImage(named:"retweet-icon.png")
            
        }
        else{
            //select
            sender.isSelected = true
            tweet.retweeted = true
            tweetCountLabel.text = String(tweet.retweetCount)
            button.imageView?.image = UIImage(named: "retweet-icon-green.png")
        }
    }
    
//        let button = sender
//        TwitterClient.sharedInstance?.retweet(tweetId: tweet.tweetID!, completion: { (error) -> (Void) in
//            if(error==nil){
//                button.imageView!.image = UIImage(named: "retweet_on.png")
//            } else {
//                print(error!)
//            }
//        })
    

    
    

}
