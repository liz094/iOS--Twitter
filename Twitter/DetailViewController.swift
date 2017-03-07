//
//  DetailViewController.swift
//  Twitter
//
//  Created by Lin Zhou on 2/28/17.
//  Copyright © 2017 Lin Zhou. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var favoritecountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    var tweet: Tweet!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
                tweetLabel.text = tweet.text
                profileImageView.setImageWith((tweet.user?.profileUrl)!)
                profileImageView.layer.cornerRadius = 5
                usernameLabel.text = tweet.user?.screenname
                //favoriteButton.imageView?.image = UIImage(named:"favor-icon.png")
                favoritecountLabel.text = String(tweet.favoritesCount)
                fullnameLabel.text = tweet.user?.name
                
                retweetCountLabel.text = String(tweet.retweetCount)
                
                let formatter = DateFormatter()
                formatter.dateFormat = "MMMM dd, yyyy 'at' h:mm aaa"
                self.timeLabel.text = formatter.string(from: tweet.timestamp!)
                
         
 
        }

        
    

    @IBAction func reply(_ sender: Any) {
    }
    
    @IBAction func favorite(_ sender: UIButton) {
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
            favoritecountLabel.text = String(tweet.favoritesCount)
            //button.imageView?.image = UIImage(named:"favor-icon.png")
            
        }
        else{
            //select
            sender.isSelected = true
            tweet.favorited = true
            favoritecountLabel.text = String(tweet.favoritesCount)
            //button.imageView?.image = UIImage(named:"favor-icon-red.png")
            
        }
    }
    @IBAction func retweet(_ sender: Any) {
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
