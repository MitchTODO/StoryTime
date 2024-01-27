//
//  MainView.swift
//  StoryTime
//
//  Created by mitchell tucker on 1/15/24.
//

import SwiftUI

struct MainView: View {
    @State private var isShowingStoryView = false
    //@State private var hasNoStories = true
    @State private var isLoading = false
    
    @State private var stories:Stories? = nil
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        NavigationStack {
            Spacer()
            NavigationLink(destination: StoryBuilderView(), isActive: $isShowingStoryView) {
                //if(hasNoStories) {
                //    Text("Go Create your first Story")
                //}else{
                EmptyView()
                // }
            }
            VStack{
                if(isLoading) {
                    Text("Loading Your Stories").font(.headline)
                    ProgressView()
                }else if(stories == nil) {
                    
                }else{
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 10) {
                            ForEach(stories!, id: \.hashID) { story in
                                NavigationLink(destination: StoryDetailView(story: story)) {
                                    StoryCellView(story: story)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle(Text("Your Stories"))
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Reload") {
                                isLoading = true
                                getStories() { result in
                                    
                                    isLoading = false
                                    stories = result
                                }
                            }
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Create") {
                                isShowingStoryView = true
                            }
                        }
                    }
                Spacer()
            }.onAppear() {
                isLoading = true
                getStories() { result in
                    
                    isLoading = false
                    stories = result
                }
            }
            
        }
    }


#Preview {
    MainView()
}

struct StoryCellView: View {
    var story: Story
    
    init(story: Story) {
        self.story = story
        print(story.title)
        print(story.hashID)
        if story.title.isEmpty {
            self.story.title = "Untitled"
        }
   
    }

    var body: some View {
        VStack {
            Text(story.title)
            Circle()
            .frame(width: 3.0,height: 3.0)
            .foregroundColor(.orange)
            HStack{
                Spacer()
            }
            Spacer()
                
        }.font(.headline)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
            .frame(height: 200.0)
    }
}
