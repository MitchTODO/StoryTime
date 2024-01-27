//
//  StoryOverView.swift
//  StoryTime
//
//  Created by mitchell tucker on 1/18/24.
//

import SwiftUI

struct StoryOverView: View {
    @EnvironmentObject var storyBuilderVM:StoryBuilderViewModel
    
    @State var editText = false
    
    var body: some View {
        VStack{
            if storyBuilderVM.isGenratingStory{
                ProgressView()
                Text("Generating Story")
            }else{
                if editText {
                    TextEditor(text: $storyBuilderVM.story)
                        .cornerRadius(30.0)
                        .background(.white).padding()
                }else{
                    Text(storyBuilderVM.story).padding()
                }
            }
        }.background(editText ? .gray : .clear)
        .toolbar {
            
            Button("Edit") {
                // Allow user to edit the stories
                editText.toggle()
            }
            
            Button("Save") {
                let shortString = String(storyBuilderVM.story.prefix(1100))
                // saving to story3
                postStory(title: storyBuilderVM.title, body: shortString) { result in
                    print(result)
                    
                }
            }.disabled(storyBuilderVM.isGenratingStory)
            
         }
    }
}

#Preview {
    StoryOverView()
}
