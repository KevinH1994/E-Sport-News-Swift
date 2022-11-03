//
//  HomeTableViewController.swift
//  E-Sport-News
//
//  Created by Kevin Hering on 18.10.22.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    
    
    var articles: [NewsFeed]!

    override func viewDidLoad() {
        super.viewDidLoad()
        getArticle()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func getArticle(){
        let urlString = "https://public.syntax-institut.de/apps/KevinHering/data.json"
        
        let url = URL(string: urlString)
        
        guard url != nil else {return}
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!){data, response, error in
            
            if error == nil && data != nil{
                let decoder = JSONDecoder()
                
                do {
                    let newsFeed = try
                    decoder.decode(NewsFeed.self, from: data!)
                    print(data)
                    //let randomArticle = newsFeed.randomElement()
                    
                    DispatchQueue.main.async {
                        //self.title.text = randomArticle?.title
                       // self.description.text = randomArticle?.description
                    }
                }catch{
                    print("Error parsin JSON")
                }
                
            }
        }
        dataTask.resume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homecell", for: indexPath) as! HomeTableViewCell
        cell.title.text = "testtesttest"

        // Configure the cell...

        return cell
    }
    

}
