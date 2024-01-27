//
//  StoryThemeView.swift
//  StoryTime
//
//  Created by mitchell tucker on 1/16/24.
//

import SwiftUI

struct StoryThemeView: View {
    
    @EnvironmentObject var storyBuilderVM:StoryBuilderViewModel
    
    let themes:[String] = ["Friendship","Family","Courage","Compassion","Be Yourself","Honesty","School","Holidays","Imagination","Morality","Growing Up","Asseptance","Anger"]
    
    var body: some View {
        VStack {
            Text("Select Your Story's Theme").font(.title)
            Text("You can select more then one theme").font(.subheadline)
            
            ForEach(themes,id:\.self) { type in
                Button(action: {
                    if(storyBuilderVM.selectedThemes[type] == true) {
                        storyBuilderVM.selectedThemes[type] = false
                    } else {
                        storyBuilderVM.selectedThemes[type] = true
                    }
                }, label: {
                    HStack {
                        Text(type)
                        Spacer()
                        
                        if(storyBuilderVM.selectedThemes[type] == true) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }).buttonStyle(.bordered)
                
            }
            Button(action: {
                storyBuilderVM.storyState = .structure
            }, label: {
                Text("Next")
            }).disabled(storyBuilderVM.selectedThemes.isEmpty)
                .buttonStyle(.borderedProminent)
        }.padding()
    }
}

#Preview {
    StoryThemeView().environmentObject(StoryBuilderViewModel())
}
