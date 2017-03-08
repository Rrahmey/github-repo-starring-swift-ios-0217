//
//  GithubAPIClient.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class GithubAPIClient {
    
    class func getRepositories(with completion: @escaping ([Any]) -> ()) {
        let urlString = "\(githubAPIURL)/repositories?client_id=\(githubClientID)&client_secret=\(githubClientSecret)"
        let url = URL(string: urlString)
        let session = URLSession.shared
        
        guard let unwrappedURL = url else { fatalError("Invalid URL") }
        let task = session.dataTask(with: unwrappedURL, completionHandler: { (data, response, error) in
            guard let data = data else { fatalError("Unable to get data \(error?.localizedDescription)") }
            
            if let responseArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [Any] {
                if let responseArray = responseArray {
                    completion(responseArray)
                }
            }
        })
        task.resume()
    }
    
    class func checkIfRepositoryIsStarred (_ repoName: String, completion: @escaping (Bool) -> () ) {
        let urlString = "\(githubAPIURL)/user/starred/\(repoName)?client_id=\(githubClientID)&client_secret=\(githubClientSecret)"
        if let url = URL(string: urlString){
            var urlRequest = URLRequest(url: url)
            
            //add http:// method
            urlRequest.httpMethod = "GET"
            
            //add header
            
            urlRequest.addValue("token \(tokenID)", forHTTPHeaderField: "Authorization")
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 204 {
                        completion(true)
                        print(response.statusCode)
                    } else {
                        completion(false)
                        print(response.statusCode)
                    }
                }
            })
            task.resume()
            
        }
    }
    
    class func starRepository(named: String, completion: @escaping () -> ()) {
        let urlString = "\(githubAPIURL)/user/starred/\(named)?client_id=\(githubClientID)&client_secret=\(githubClientSecret)"
        if let url = URL(string: urlString){
        var urlRequest = URLRequest(url: url)
        
        //add http:// method
        urlRequest.httpMethod = "PUT"
        
        //add header
        
        urlRequest.addValue("token \(tokenID)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 204 {
                    print("repo was starred")
                    completion()
                } else {
                    print("repo was not starred")
                    completion()
                }
            }
            
        })
        dataTask.resume()
    }
    }
    
    class func unstarRepository(named: String, completion: @escaping () -> ()) {
        let urlString = "\(githubAPIURL)/user/starred/\(named)?client_id=\(githubClientID)&client_secret=\(githubClientSecret)"
        if let url = URL(string: urlString){
            var urlRequest = URLRequest(url: url)
            
            //add http:// method
            urlRequest.httpMethod = "DELETE"
            
            //add header
            
            urlRequest.addValue("token \(tokenID)", forHTTPHeaderField: "Authorization")
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 204 {
                        print("repo was starred")
                        completion()
                    } else {
                        print("repo was not starred")
                        completion()
                    }
                }
                
            })
            dataTask.resume()
        }
    }
    
}
