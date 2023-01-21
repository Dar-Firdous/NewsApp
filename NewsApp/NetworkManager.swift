//
//  NetworkManager.swift
//  NewsApp
//
//  Created by FIRDOUS UR RASOOL on 01/07/22.
//

import Foundation
 final class Apicaller{
    let shared = Apicaller()
    struct Constants {
        static let topHeadlinesUrl = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=4c837a87f2d14087a649c43024ef287e"
    }
    private init() {}
    
    static public func getTopStories(completion: @escaping(Result<[Articles],Error>) -> Void){
        guard let url = URL(string: Constants.topHeadlinesUrl) else {return}
        let task = URLSession.shared.dataTask(with: url){(data, response, error) in
            if let error = error{
                completion(.failure(error))
            }
            else if let data = data{
                do{
                    let result = try! JSONDecoder().decode(APIResponse.self, from: data)
                    print(result.articles.count)
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }.resume()
        
    }
    
}
