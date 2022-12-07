//
//  HomeTableViewController.swift
//  E-Sport-News
//
//  Created by Kevin Hering on 18.10.22.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    let apiNewsClient = ApiNewsClient()
    var articles = [NewsFeed]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiNewsClient.fetchNews{ news in news
            self.articles = news.news!
            print(news.news!)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
            
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    
   

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homecell", for: indexPath) as! HomeTableViewCell
       
        let article = self.articles[indexPath.row]
        DispatchQueue.main.async {
            cell.title.text = article.titel ?? "Titel"
            cell.discription.text = article.description ?? "Discription"}
        DispatchQueue.global(qos: .background).async{
            
        
            
            if let data = try? Data(contentsOf: URL(string: article.thumnail ?? "" )!){
                DispatchQueue.main.async {
                    cell.bild.image = UIImage(data: data)
                }
                    
                
                
            }
        }

        
        

        // Configure the cell...

        return cell
    }
    

}
