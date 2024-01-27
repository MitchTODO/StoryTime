//
//  StoryTypeView.swift
//  StoryTime
//
//  Created by mitchell tucker on 1/15/24.
//

import SwiftUI

struct StoryBuilderView: View {
    
    @StateObject var storyBuilderVM = StoryBuilderViewModel()

    func viewForStep() -> AnyView {
        switch(storyBuilderVM.storyState) {
            //case .length:
            //    return(AnyView(StoryLengthView().environmentObject(storyBuilderVM)))
            case .type:
                return(AnyView(StoryGenresView().environmentObject(storyBuilderVM)))
            case .themes:
                return(AnyView(StoryThemeView().environmentObject(storyBuilderVM)))
            case .structure:
                return(AnyView(StoryCharactersViews().environmentObject(storyBuilderVM)))
            case .background:
                return(AnyView(StoryBackground().environmentObject(storyBuilderVM)))
            case .finish:
                return(AnyView(StoryDetails().environmentObject(storyBuilderVM)))
            case .storyOverView:
                return(AnyView(StoryOverView().environmentObject(storyBuilderVM)))
        }
    }

    var body: some View {
        
        VStack{
            Spacer()
            ScrollView {
                viewForStep()
            }
            Spacer()
        }.navigationTitle("Story Builder")
            .navigationBarTitleDisplayMode(.inline)
            
    }
}

#Preview {
    StoryBuilderView()
}
