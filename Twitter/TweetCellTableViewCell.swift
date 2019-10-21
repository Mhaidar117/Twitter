//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Michael Haidar on 10/2/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    @IBOutlet weak var tweetContent: UILabel!
    
    //favorite button outlet
    @IBOutlet weak var favButton: UIButton!
    
    
    var favorited:Bool = false
    var tweetId:Int = -1
    //var retweeted:Bool = false
    
    //favorite button action
    @IBAction func favorite(_ sender: Any) {
        let toBeFavorited = !favorited
        if(toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId , success: {
                self.setFavorite(isFavorited: true)
            }, failure: { (error) in
                print("did not favorite: \(error)")
            })
        }else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(isFavorited: false)
            }, failure: { (error) in
                print("did not unfavorite: \(error)")
            })
        }
    }
   
 
    
    func setFavorite( isFavorited:Bool) {
        favorited = isFavorited
        if(favorited) {
            favButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        }else{
            favButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    //retweet button outlet
    @IBOutlet weak var reTweetButton: UIButton!
    
    //retweet button action
    @IBAction func retweet( sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(isRetweeted: true)
        }, failure: { (error) in
            print("error in retweeting: \(error)")
        })
    }
    
    func setRetweeted(isRetweeted:Bool) {
        if (isRetweeted){
            reTweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            reTweetButton.isEnabled = false
        }else{
            reTweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            reTweetButton.isEnabled = true
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

}
