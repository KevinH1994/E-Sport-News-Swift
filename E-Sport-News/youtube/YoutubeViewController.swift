//
//  YoutubeViewController.swift
//  E-Sport-News
//
//  Created by Kevin Hering on 10.11.22.
//

import UIKit
import youtube_ios_player_helper

class YoutubeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var ytTV: UITableView!
    var ytList : YoutubeV3? = nil
    let yTClient = ApiYoutubeClient()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ytTV.delegate = self
        ytTV.dataSource = self
      
       
        
        yTClient.fetchYoutube{youtube in youtube
            self.ytList = youtube
            print(youtube.items)
            
            DispatchQueue.main.async {
                self.ytTV.reloadData()
            }
            
            
        }// Do any additional setup after loading the
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        var i = 0
        if ytList != nil {
            for item in ytList!.items{
            
                if item.id.videoID != nil{
                    count += 1
                    
                }else{
                    ytList?.items.remove(at: i)
                }
                i += 1
            }
            
        }
        print(count)
        return count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "youtubecell", for: indexPath) as! YoutubeTableViewCell
        if ytList != nil {
            if let videoId = ytList?.items[indexPath.row].id.videoID{
                cell.ytView.load(withVideoId: videoId)

            }else{
                cell.isHidden = true
            }
            
            }
        
        return cell
    }

}
