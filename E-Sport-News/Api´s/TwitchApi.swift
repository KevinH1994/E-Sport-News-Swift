//
//  TwitchApi.swift
//  E-Sport-News
//
//  Created by Kevin Hering on 21.11.22.
//

import Foundation

struct ApiTwitchClient {
    let baseUrl = ""
    
    func fetchTwitch(completion : @escaping ()-> Void ) {
        let urlString = baseUrl
        let url = URL(string: urlString)
        guard url != nil else {return}
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with:url!) {
            data, response, error in
            
            if error == nil && data != nil{
                let decooder = JSONEncoder()
                
                do{
                    let twitchFeed = try
                  //  decooder.decode("" , from: data!)
                    completion()
                }catch{
                    print("Error in Twitch")
                }
            }
        }
        dataTask.resume()
    }
}
