//
//  User.swift
//  Twitter
//
//  Created by Lin Zhou on 2/24/17.
//  Copyright © 2017 Lin Zhou. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name : String?
    var screenname: String?
    var profileUrl: URL?
    var bgImageUrl: String?
    var tagline: String?
    var followersCount: Int?
    var followingCount: Int?
    var tweetCount: Int?
    
    var dictionary: NSDictionary?
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    init(dictionary: NSDictionary){
        
        self.dictionary = dictionary
        /*print("name: \(user.name)
        print("screenname: \(user["screen_name"])")
        print("profile url: \(user["profile_image_url_https"])")
        print("description: \(user["description"])")*/

        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        followersCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        tweetCount = dictionary["statuses_count"] as? Int
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString{
            profileUrl = URL(string: profileUrlString)

        }
        
        
        bgImageUrl = dictionary["profile_banner_url_https"] as? String
        
        tagline = dictionary["description"] as? String
    }
    
    static var _currentUser: User?
    
    class var currentUser: User?{
        get {
            if _currentUser == nil{
            let defaults = UserDefaults.standard
            let userData = defaults.object(forKey: "currentUserData") as? Data
            
            if let userData = userData{
                if let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as? NSDictionary{
                
                _currentUser = User(dictionary: dictionary)
                }
            }
            }
            
            return _currentUser

    }
    
        
        set(user){
            _currentUser = user
            let defaults = UserDefaults.standard
            
            if let user = user{
            
            let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                
                defaults.set(data, forKey:"currentUserData")
            }else{
                defaults.removeObject(forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
        
    }

}
