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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
