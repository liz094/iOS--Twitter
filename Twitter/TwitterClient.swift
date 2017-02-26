//
//  TwitterClient.swift
//  Twitter
//
//  Created by Lin Zhou on 2/24/17.
//  Copyright © 2017 Lin Zhou. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance = TwitterClient(baseURL: URL(string:"https://api.twitter.com"), consumerKey: "0LPYCLahkhZVde6nzASWLGKhv", consumerSecret: "r96YPLvotYItD1d4EbAb6KTZAPd3UgFlIwqU38BkRre4jUT5Zu")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error)-> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()){  //declare a closure
        
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitter://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            UIApplication.shared.openURL(url)
            //UIApplication.shared.open(url!, options: , completionHandler: nil)
            
        }) { (error: Error?) in
            print("error:\(error?.localizedDescription)")
            self.loginFailure?(error!)
        }

    }
    
    func logout(){
        User.currentUser = nil
        
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserDidLogout"), object: nil)
    }

    func handleOpenUrl(url:URL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            
            self.currentAccount(success: { (user:User) in
                User.currentUser = user //call setter and save
                self.loginSuccess?()
            }, failure: { (error:Error) in
                self.loginFailure?(error)
            })
            
            self.loginSuccess?()
            
        }, failure: { (error:Error?) in
            print("error:\(error?.localizedDescription)")
            self.loginFailure?(error!)
        })
        
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()){  //closure, success: hand in return nothing
        
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) ->Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)

            //call the closure
            success(tweets)
        }, failure: { (task:URLSessionDataTask?, error:Error) ->Void in
            failure(error)
        })
        
    }
    
    func currentAccount(success:@escaping (User)->(), failure: @escaping (Error)->()){
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task:URLSessionDataTask, response: Any?) ->Void in
            print("account: \(response)")
            let userDictionary = response as! NSDictionary
            //print("user:\(user)")
            
            let user = User(dictionary: userDictionary)
            
            success(user)
            
        }, failure: { (task: URLSessionDataTask?, error: Error)->Void in
            failure(error)
        })
    }
    
}
