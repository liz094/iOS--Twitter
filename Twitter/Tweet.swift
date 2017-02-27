//
//  Tweet.swift
//  Twitter
//
//  Created by Lin Zhou on 2/24/17.
//  Copyright © 2017 Lin Zhou. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var user: User?
    var text: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoritesCount :Int = 0
    var tweetID: String?
    
    var favorited: Bool{
        didSet{
            if (favorited){
                favoritesCount += 1
                TwitterClient.sharedInstance?.favorite(tweetID: tweetID, favorite: true)
            }
            else{
                favoritesCount -= 1
                TwitterClient.sharedInstance?.favorite(tweetID: tweetID, favorite: false)
            }
        }
    }
    
    var retweeted: Bool {
        didSet {
            if (retweeted) {
                retweetCount += 1
                TwitterClient.sharedInstance?.favorite(tweetID: tweetID, favorite: favorited)
            
            }
                    else {
                retweetCount -= 1
                TwitterClient.sharedInstance?.favorite(tweetID: tweetID, favorite: favorited)
                
            }
            
        }
    }
    
    init(dictionary: NSDictionary){
        
        text = dictionary["text"] as? String
        user = User(dictionary: dictionary["user"] as! NSDictionary)
                
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        tweetID = dictionary["id str"] as? String
        favorited = (dictionary["favorited"] as? Bool) ?? false
        retweeted = (dictionary["retweeted"] as? Bool) ?? false

        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString{
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
        }
 
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
            
        }
        return tweets
    }

}
