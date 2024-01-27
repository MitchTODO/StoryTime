//
//  GPTService.swift
//  StoryTime
//
//  Created by mitchell tucker on 1/17/24.
//

import Foundation

struct ChatStory:Codable {
    var title:String
    var body:String
}
    
let chatGPTApiKey = ""
func chatWithGPT(prompt: String, completion: @escaping (String?) -> Void) {

    let endpoint = "https://api.openai.com/v1/chat/completions"
    
    guard let url = URL(string: endpoint) else {
        completion(nil)
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("Bearer \(chatGPTApiKey)", forHTTPHeaderField: "Authorization")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let promptData = ["role": "user", "content": prompt]
        
    let requestData: [String: Any] = ["model": "gpt-3.5-turbo", "messages": [["role": "system", "content": "You are a story teller, skilled in creating fun power short stories in under 150 words. Stories are primally designed for children aged from 3 to 12. Stories need a title and body."], promptData]]
    
    guard let jsonData = try? JSONSerialization.data(withJSONObject: requestData) else {
        completion(nil)
        return
    }
  
    request.httpBody = jsonData
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

        guard let data = data, error == nil else {
            completion(nil)
            return
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
      
            if let choices = json?["choices"] as? [[String: Any]], let assistantReply = choices.first?["message"] as? [String: Any], let content = assistantReply["content"] as? String {
                
                completion(content)
                   
            } else {
                completion(nil)
            }
        } catch {
            completion(nil)
        }
    }
    
    task.resume()
}


