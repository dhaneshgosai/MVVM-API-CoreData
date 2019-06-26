//
//  APIService.swift
//  DemoAPI+MVVM+CoreData
//
//  Created by Sheshnath on 26/06/19.
//  Copyright © 2019 Exp. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String : Any]

class APIService {
    
    //Define Base URL
    
    //News HeadLine Data URL
    private let sourcesURL = URL(string: "https://newsapi.org/v2/sources?apiKey=0cf790498275413a9247f8b94b3843fd")!
    
    func loadHeadlinesData(request_param: [String: Any], completion : @escaping ([Headline]?, Error?) -> ()) {
        
        
        var request = URLRequest(url: sourcesURL)
        request.httpBody = request_param.percentEscaped().data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if (error != nil) {
                if let responseData = data {
                    let json = try! JSONSerialization.jsonObject(with: responseData, options: .mutableLeaves)
                    let result = json as! JSONDictionary
                    let dict = result["articles"] as! [JSONDictionary]
                    let headlines = dict.compactMap(Headline.init)
                    completion(headlines,nil)
                }
            } else {
                //Return Error
                completion(nil, error)
            }
        }.resume()
        
    }
    
}

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return escapedKey + "=" + escapedValue
            }
            .joined(separator: "&")
    }
}
