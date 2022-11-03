//
//  ApiNews.swift
//  E-Sport-News
//
//  Created by Kevin Hering on 03.11.22.
//

import Foundation

struct ApiNewsClient{
    let baseUrl = "https://public.syntax-institut.de/apps/KevinHering/data.json"
    
    func fetchNews(completion: @escaping(News) -> Void){
        
        let urlString = baseUrl
        let url = URL(string: urlString)
        guard url != nil else {return}
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with:url!) {
            data, response, error in
            
            if error == nil && data != nil{
                let decoder = JSONDecoder()
                
                do{
                    let newsFeed = try decoder.decode(News.self, from: data!)
                    completion(newsFeed)
                }catch{
                    print("Error in JSON parsing")
                }
            }
        }
        dataTask.resume()
    }
}
