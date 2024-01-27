//
//  StoryTypeView.swift
//  StoryTime
//
//  Created by mitchell tucker on 1/16/24.
//

import SwiftUI

struct StoryGenresView: View {
    
    @EnvironmentObject var storyBuilderVM:StoryBuilderViewModel
    
    let genres:[String] = ["Fairy tale","Adventure","Fantasy","Historical fiction","Mystery","Fable","Poem"]
    
    var body: some View {
        VStack {
            Text("Select Your Story Details")
                .font(.title2)
            Spacer()
            VStack(alignment: .leading) {
                Section("Genre") {
                    ForEach(genres,id:\.self) { type in
                        Button(action: {
                            storyBuilderVM.selectGenres = type
                        }, label: {
                            HStack {
                                Text(type)
                                Spacer()
                                if(storyBuilderVM.selectGenres == type) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                        }).buttonStyle(.bordered)
                    }
                }

            }
            Spacer()
            Button(action: {
                storyBuilderVM.storyState = .themes
            }, label: {
                Text("Next")
            }).disabled(storyBuilderVM.selectGenres.isEmpty)
                .buttonStyle(.borderedProminent)
        }.padding()
    }
}

#Preview {
    StoryGenresView().environmentObject(StoryBuilderViewModel())
}
