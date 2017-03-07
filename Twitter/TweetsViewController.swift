//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Lin Zhou on 2/24/17.
//  Copyright © 2017 Lin Zhou. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var tweets = [Tweet]()
    //var user = User.currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200

        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
//            self.user = user
//            for tweet in tweets{
//                print(tweet.text as Any)
//            }
        }, failure: { (error:Error) in
            print(error.localizedDescription)
        })

        //tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        let tweet = tweets[indexPath.row]

        cell.tweet = tweet
        cell.delegate = self as? TweetTableViewCellDelegate //assign the cell's delegate to this view controller, so that this controller can handle pushing the profileViewController or perform segue
       
        return cell
    }

    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

//    func imageClicked(){
//        print("image tapped")
//        self.performSegue(withIdentifier: "toProfile", sender: Any?)
//    }
    
    
    // MARK: - Navigation
/*
    func prepare(for segue: UIStoryboardSegue, sender: UIButton){
        let cell = sender as! TweetCell
        let indexPath = tableView.indexPath(for: cell)
        let tweet
        
    }*/
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier != "toDetail"){
            return
    }
        let cell = sender as! TweetCell
        let indexPath = tableView.indexPath(for: cell)
        
        let tweet = tweets[indexPath!.row]
        
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.tweet = tweet
//        }
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
extension TweetsViewController: TweetTableViewCellDelegate{
    func profileImageViewTapped(cell: TweetCell, user: User) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewVontroller") as? ProfileViewController{
            profileVC.user = user
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
}




