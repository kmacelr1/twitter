//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Kharee MacElree on 2/10/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var tweetArray = [NSDictionary]()
    var numberOfTweets: Int!
    
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadTweets()
        
        myRefreshControl.addTarget(self, action:#selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 150
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadTweets()
    }
    
    
    @objc func loadTweets(){
        numberOfTweets = 20
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count": numberOfTweets]
            
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
                
                self.tableView.reloadData()
                self.myRefreshControl.endRefreshing()
                
            }
            }, failure: { (Error) in
                    print("Could not retrieve tweets")
                })
                
            }
    
    
    func loadMoreTweets(){
        
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweets = numberOfTweets + 20
        let myParams = ["count": numberOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
        self.tweetArray.removeAll()
        for tweet in tweets{
            self.tweetArray.append(tweet)
            
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
            
        }
        }, failure: { (Error) in
                print("Could not retrieve tweets")
            })
            
        
    }
    
    
    
    
    
    
    
    @IBAction func onLogout(_ sender: Any) {
        
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count{
            loadMoreTweets()
            
        }
    }
    
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCelltableViewCell
        
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        cell.userNameLabel.text = user["name"] as? String
        
        let atName = user["screen_name"] as! String
        
        cell.atNameLabel.text = "@\(atName)"
        cell.tweetContentLabel.text = tweetArray[indexPath.row][("text")] as? String
        
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            
            cell.profileImageView.image = UIImage(data: imageData)
           // cell.profileImageView.image = tweetArray[indexPath.row][("profile_image_url_https")] as? UIImage
        }
        
        
        
        cell.setFavorite(tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.setRetweet(tweetArray[indexPath.row]["retweeted"] as! Bool)
        cell.tweetID = tweetArray[indexPath.row]["id"] as! Int
        
        return cell
    }
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
