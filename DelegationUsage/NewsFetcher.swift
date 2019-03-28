//
//  NewsFetcher.swift
//  DelegationUsage
//
//  Created by Sprinthub on 28/03/2019.
//  Copyright © 2019 Sprinthub Mobile. All rights reserved.
//

import Foundation


public protocol NewsFetcherDelegate : class {
    func showArticles(articles: Data)
    func showError(error: String)
}


class NewsFetcher{
    
    var delegate : NewsFetcherDelegate?
    
    func getArticles(){
        let urlString : String = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        
        //check url and get data
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                
                DispatchQueue.main.async {
                    self.delegate?.showArticles(articles: data)
                }
                return
            }else{
                DispatchQueue.main.async {
                    self.delegate?.showError(error: "Failed to fetch, possible network error")
                }
            }
        }else{
            DispatchQueue.main.async {
                self.delegate?.showError(error: "Invalid URL")
            }
        }
    }
    
    
    
}
