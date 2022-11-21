//
//  YoutubeTableViewCell.swift
//  E-Sport-News
//
//  Created by Kevin Hering on 10.11.22.
//

import UIKit
import youtube_ios_player_helper

class YoutubeTableViewCell: UITableViewCell, YTPlayerViewDelegate {
    
    @IBOutlet weak var ytView: YTPlayerView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
       
     
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView){
        playerView.playVideo()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
