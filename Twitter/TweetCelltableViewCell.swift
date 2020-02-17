//
//  TweetCelltableViewCell.swift
//  Twitter
//
//  Created by Kharee MacElree on 2/10/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCelltableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    @IBOutlet weak var atNameLabel: UILabel!
    
    
    @IBOutlet weak var tweetContentLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var liked:Bool = false
    var tweetID:Int = -1
    var retweeted:Bool = false
    

    func setRetweet(_ isRetweeted:Bool){
        retweeted = isRetweeted
        
        if(retweeted){
            if #available(iOS 13.0, *) {
                retweetButton.setImage(UIImage(systemName:"arrow.2.circlepath.circle.fill"), for: UIControl.State.normal)
                
                //retweetButton.isEnabled = false
            } else {
                // Fallback on earlier versions
            }
        }
            
        else{
            if #available(iOS 13.0, *) {
                retweetButton.setImage(UIImage(systemName:"arrow.2.circlepath.circle"), for: UIControl.State.normal)
                
                //retweetButton.isEnabled = true
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    
    
  
    
    
    @IBAction func retweet(_ sender: UIButton) {
        TwitterAPICaller.client?.retweet(tweetID: tweetID, success: {self.setRetweet(true)}, failure: { (Error) in
                       print("Retweet did not work \(Error)")
                   })
        
        TwitterAPICaller.client?.unretweet(tweetID: tweetID, success: {self.setRetweet(false)}, failure: { (Error) in
            print("Unretweet did not work \(Error)")
        })
    }
    
    
    

    
    //the following code is related to favoriting tweets****************************************
    
    func setFavorite(_ isLiked:Bool){
        liked = isLiked
        
        if(liked){
            if #available(iOS 13.0, *) {
                likeButton.setImage(UIImage(systemName:"heart.fill"), for: UIControl.State.normal)
            } else {
                // Fallback on earlier versions
            }
        }
            
        else{
            if #available(iOS 13.0, *) {
                likeButton.setImage(UIImage(systemName:"heart"), for: UIControl.State.normal)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    
    
    @IBAction func likeTweet(_ sender: Any) {
        
        let toBeLiked = !liked
        if(toBeLiked) {
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetID, success: {self.setFavorite(true)}, failure: { (Error) in
                print("Favorite did not succeed: \(Error)")
            })
            
        }
            
        else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetID: tweetID, success: {self.setFavorite(false)}, failure: { (Error) in
                print("Unfavorite did not succeed: \(Error)")
                
            })
        }
    }
//*********************************************************************************************************/

 

}
