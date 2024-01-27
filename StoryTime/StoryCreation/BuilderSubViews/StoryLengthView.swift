//
//  StoryStyleView.swift
//  StoryTime
//
//  Created by mitchell tucker on 1/16/24.
//

import SwiftUI

struct StoryLengthView: View {
    let style:[String] = ["Short > 2","Long < 2"]
   
    @State var other = ""
    
    @EnvironmentObject var storyBuilderVM:StoryBuilderViewModel
    
    var body: some View {
        Text("Select Your Story Length")
            .font(.title2)
        
        HStack {
            ForEach(style,id:\.self) { type in
                Button(action: {
                    storyBuilderVM.selectedLength = type
                }, label: {
                    HStack {
                        Text(type)
                        Spacer()
                        if(storyBuilderVM.selectedLength == type) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }).buttonStyle(.bordered)
            }
        }.padding()
        Button(action: {
            storyBuilderVM.storyState = .themes
        }, label: {
            Text("Next")
        }).disabled(storyBuilderVM.selectedLength.isEmpty)
          .buttonStyle(.borderedProminent)
    }
}

#Preview {
    StoryLengthView().environmentObject(StoryBuilderViewModel())
}
