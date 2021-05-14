//
//  APIbase.swift
//  NewsApp
//
//  Created by Anton Tuzov on 14.05.2021.
//

import Foundation



class APIBase {
    
    static let shared = APIBase()
    
    
    
    
    struct Constants {
        static let topURL = URL(string: "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=79f8d87a24534c508bbd48a20a487110")
        
        
    }
    
    
    private init() {}
   
    
  public func getNews(completion: @escaping (Result<[Article]? , Error>) -> Void) {
        
        guard let url = Constants.topURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print(result.articles?.count)
                    completion(.success(result.articles))
                    
                } catch {
                    completion(.failure(error))
                    
                }
                
            }
           
            
            
        }
        task.resume()
        

    }


    
    
    
    
    
    
    
}
