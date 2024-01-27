//
//  Story3Service.swift
//  StoryTime
//
//  Created by mitchell tucker on 1/21/24.
//

import Foundation

let apiKey = "YOUR KEY HERE"

func getStories(completion: @escaping([Story]?) -> Void) {

    let endpoint = "https://story3.com/api/v2/stories/my"
    
    guard let url = URL(string:endpoint) else {
        completion(nil)
        return
    }
    
    var request = URLRequest(url:url)
    request.httpMethod = "GET"
    request.addValue("\(apiKey)", forHTTPHeaderField: "x-auth-token")
    request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

        guard let data = data else {
            completion(nil)
            return
        }

        do {
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(Stories.self,from: data)
            completion(jsonData)
            
        } catch {
            completion(nil)
        }
    }
    task.resume()
}

func postStory(title:String,body:String,completion: @escaping(Bool) -> Void) {

    let endpoint = URL(string:"https://story3.com/api/v2/stories/")!
    
    var request = URLRequest(url:endpoint)
    request.httpMethod = "POST"
    request.addValue("\(apiKey)", forHTTPHeaderField: "x-auth-token")
    request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let jsonBody:[String:Any] = [
        "title":title,
        "body":body
    ]
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: jsonBody)
    } catch {
        print("Error encoding JSON: \(error)")
        return
    }

    // Make the request
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        // Handle the response
        if let error = error {
            print("Error: \(error)")
        } else if let data = data {
            // Process the response data
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                print("Response: \(jsonResponse)")
            } catch {
                print("Error decoding JSON response: \(error)")
            }
        }
    }
    // Start the task
    task.resume()
}

func postTwist(hashParentId:String, title:String, body:String ,completion: @escaping(Bool) -> Void) {
    // Post request for twist

    let endpoint = URL(string:"https://story3.com/api/v2/twists")!
    
    var request = URLRequest(url:endpoint)
    request.httpMethod = "POST"
    request.addValue("\(apiKey)", forHTTPHeaderField: "x-auth-token")
    request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let jsonBody:[String:Any] = [
          "hashParentId": hashParentId,
          "isExtraTwist": false,
          "title": title,
          "body": body
    ]
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: jsonBody)
    } catch {
        print("Error encoding JSON: \(error)")
        return
    }

    // Make the request
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        // Handle the response
        if let error = error {
            print("Error: \(error)")
        } else if let data = data {
            // Process the response data
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                print("Response: \(jsonResponse)")
            } catch {
                print("Error decoding JSON response: \(error)")
            }
        }
    }
    // Start the task
    task.resume()
}


func getTwist(hashId:String, completion: @escaping(StoryWithTwist?) -> Void) {
    let endpoint = "https://story3.com/api/v2/stories/\(hashId)"
    
    guard let url = URL(string:endpoint) else {
        completion(nil)
        return
    }
    
    var request = URLRequest(url:url)
    request.httpMethod = "GET"
    request.addValue("\(apiKey)", forHTTPHeaderField: "x-auth-token")
    request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

        guard let data = data else {
            completion(nil)
            return
        }
   
        do {
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(StoryWithTwist.self,from: data)
            completion(jsonData)
            
        } catch {
            completion(nil)
        }
    }
    task.resume()
}
