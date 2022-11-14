//
//  ApiYoutube.swift
//  E-Sport-News
//
//  Created by Kevin Hering on 11.11.22.
//

import Foundation

struct ApiYoutubeClient{
    
let baseUrl = ""
    
    func fetchYoutube(completion: @escaping(YoutubeV3) -> Void){
        let urlString = baseUrl
        let url = URL(string: urlString)
        guard url != nil else {return}
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!){
            data, response, error in
            
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                
                do{
                    let youtube = try
                    decoder.decode(YoutubeV3.self,from: data!)
                    completion(youtube)
                }catch{
                    print("Error in JSON parsing")
                }
            }
            
        }
        dataTask.resume()
    }
    
}
