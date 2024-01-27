//
//  StoryCharactersViews.swift
//  StoryTime
//
//  Created by mitchell tucker on 1/16/24.
//

import SwiftUI

struct StoryCharactersViews: View {
    
    @EnvironmentObject var storyBuilderVM:StoryBuilderViewModel
    
    @State var numberOfPeople = 1
    var body: some View {
        VStack {
            VStack{
                Text("Create your charaters!").font(.title)
                Text("Hint: This could be, pet names, loved ones or important people in your life.").font(.subheadline)
                Text("Example: 'A big white dog named Lulu'").font(.headline)
            }.padding()
            VStack {
                TextField("Protagonist",text: $storyBuilderVM.protagonist)
                TextField("Antagonist", text: $storyBuilderVM.antagonist)
            }.padding()

            VStack{
                
                Text("Optional")
                    .padding(.top)
                    .bold()
                    .font(.caption)
                    .multilineTextAlignment(.center)
                VStack {
                    
                    TextField("SideKick", text: $storyBuilderVM.sidekick)
                    TextField("Confidante",text: $storyBuilderVM.confidante)
                }.padding()
                
            }.background(.bar)
                .clipShape(.containerRelative)
               
            Button(action: {
                storyBuilderVM.storyState = .background
            }, label: {
                Text("Next")
            }).buttonStyle(.borderedProminent)
               
        }.textFieldStyle(.roundedBorder)
        .multilineTextAlignment(.center)
    }
}

#Preview {
    StoryCharactersViews().environmentObject(StoryBuilderViewModel())
}
