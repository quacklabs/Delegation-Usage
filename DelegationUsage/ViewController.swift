//
//  ViewController.swift
//  DelegationUsage
//
//  Created by Sprinthub on 28/03/2019.
//  Copyright © 2019 Sprinthub Mobile. All rights reserved.
//

import UIKit


class ViewController: UITableViewController, NewsFetcherDelegate {
    
    
    
    //define object to hold our articles
    var articles = [Article]()
    var newsFetcher = NewsFetcher()
    var activityIndicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newsFetcher.delegate = self
        activityIndicator("Loading Articles")
        newsFetcher.getArticles()
    }
    
    
    func showArticles(articles: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Articles.self, from: articles) {
            self.articles = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    
    //function to handle selected row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ArticleDetailViewController()
        vc.detailItem = articles[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //get a count of rows in our table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let article = articles[indexPath.row]
        cell.textLabel?.text = article.title
        cell.detailTextLabel?.text = article.body
        return cell
    }

    
    func showError(error: String) {
        let ac = UIAlertController(title: "Loading error", message: error, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func activityIndicator(_ title: String) {
        

        activityIndicator.removeFromSuperview()
//        effectView.removeFromSuperview()
//
//        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
//        strLabel.text = title
//        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
//        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
//
//        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
//        effectView.layer.cornerRadius = 15
//        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        view.addSubview(activityIndicator)
        
        activityIndicator.frame = view.bounds
        
        activityIndicator.startAnimating()
        
        
//        effectView.contentView.addSubview(strLabel)
//        view.addSubview(effectView)
    }
    
}

