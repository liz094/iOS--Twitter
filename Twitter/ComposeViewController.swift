//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Lin Zhou on 3/6/17.
//  Copyright © 2017 Lin Zhou. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    var user = User.currentUser

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.sizeToFit()
        textField.becomeFirstResponder()
        
        profileImageView.setImageWith((user?.profileUrl)!)
        nameLabel.text = user?.name
        userNameLabel.text = user?.screenname
        // Do any additional setup after loading the view.
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
