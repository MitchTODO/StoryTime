//
//  TwistViewModel.swift
//  StoryTime
//
//  Created by mitchell tucker on 1/26/24.
//

import Foundation


class TwistViewModel:ObservableObject {
    @Published var twistTitle = ""
    @Published var twistBody = ""
    @Published var twistTags = ""
    @Published var twistSummary = ""
    
    
    func createTwist(completion: @escaping (Bool) -> Void) {
        
    }
}
