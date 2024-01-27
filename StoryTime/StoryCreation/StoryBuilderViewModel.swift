//
//  StoryCreationVM.swift
//  StoryTime
//
//  Created by mitchell tucker on 1/16/24.
//

import Foundation

class StoryBuilderViewModel:ObservableObject {
    
    
    enum StoryState{
        case themes,type,structure,background,finish,storyOverView
    }
    
    @Published var selectGenres:String = "Mystery"
    @Published var selectedLength:String = ""
    @Published var selectedThemes:[String:Bool] = [:]
    
    
    @Published var protagonist = ""
    @Published var antagonist = ""
    @Published var sidekick = ""
    @Published var confidante = ""
    
    @Published var location = ""
    @Published var weather = ""
    @Published var season = ""
    
    @Published var storyState:StoryState = .type
    
    @Published var isGenratingStory = false
    @Published var story = ""
    @Published var title = ""
    
    func generateStory() {
        isGenratingStory = true
        createStory() { gStory in
            self.title = gStory.slice(from:"Title:", to: "\n\n") ?? ""
            self.story = gStory
            
            self.isGenratingStory = false
        }
    }
        
    func createStory(completion: @escaping (String) -> Void) {
        var themes = ""
        
        for key in selectedThemes.keys {
            themes.append(" \(key),")
        }
        
        let prompt = "Write a short  \(selectGenres) story about a protagnist: \(protagonist) that has a sidekick: \(sidekick), confidante: \(confidante) and antagonist:\(antagonist) that go on a adventure in the \(weather) \(location) during the \(season), telling a story about \(themes). Stories must be under 1200 characters."
        
        chatWithGPT(prompt: prompt) { result in
            if result == nil {
                completion("AI failed to create a story.")
            }
            
            completion(result!)
        }
        
        
        /*
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let story = "Once upon a time, in a small town nestled between rolling hills, there lived a lovable furry friend named Lulu. Lulu was no ordinary dog - she had an adventurous spirit and loved exploring the great outdoors. One sunny day, Lulu met a young boy named Jake, who had just moved to the town.\n\nJake was feeling a little lonely in his new surroundings, missing his old friends from his old home. But when he saw Lulu wagging her tail with excitement, he knew that maybe, just maybe, this dog could become his new best friend.\n\nFrom that day forward, Lulu and Jake were inseparable. They spent hours playing fetch at the park, going on long walks through the woods, and even sharing delicious ice cream cones. Lulu had a magical way of making Jake feel happy and loved, just like how true friends do.\n\nOne day, Lulu's wagging tail led her and Jake to a hidden treasure map that they found hanging on a nearby tree. With curiosity twinkling in their eyes, they decided to embark on an exciting adventure to find the treasure together.\n\nAs they followed the twists and turns marked on the map, Lulu's keen sense of smell and Jake's sharp eyes made for a powerful duo. They encountered obstacles along the way, like crossing treacherous bridges and climbing steep mountains, but their friendship gave them strength and courage.\n\nThey met fantastical creatures like talking birds and mischievous squirrels, who cheered them on and helped them overcome hurdles. Every step of the journey brought them closer as friends, and their laughter echoed through the forests, spreading joy to everyone they met.\n\nFinally, after a long and thrilling quest, Lulu and Jake reached their destination. Hidden beneath a tall tree, they discovered a chest filled with gold coins and sparkling jewels. But more importantly, they found a note that read, \"The greatest treasure of all is the friendship you share.\"\n\nLulu and Jake looked at each other, realizing that the real treasure was the bond they had formed during their adventure. With big smiles and hearts full of gratitude, they decided to share their newfound wealth with the people in their town, bringing joy to everyone they met.\n\nFrom that day forward, Lulu and Jake became known as the inseparable duo, spreading tales of friendship and reminding everyone that true treasure lies in the love we share with one another.\n\nAnd so, with Lulu's wagging tail leading the way and Jake's laughter echoing through the town, they continued their adventures together, forever bound by the strongest bond - the bond of friendship.\n\nThe end."
            completion(story)
        }
        */
    }
}

extension String {
    
    func slice(from: String, to: String) -> String? {
        guard let rangeFrom = range(of: from)?.upperBound else { return nil }
        guard let rangeTo = self[rangeFrom...].range(of: to)?.lowerBound else { return nil }
        return String(self[rangeFrom..<rangeTo])
    }
    
}
