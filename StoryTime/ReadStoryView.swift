//
//  ReadStoryView.swift
//  StoryTime
//
//  Created by mitchell tucker on 1/22/24.
//

import SwiftUI

struct ReadStoryView: View {
    let story: Story // Story model
    
    @State var paths:StoryWithTwist? = nil
    @State var isloading = false
    
    init(story: Story) {
        self.story = story
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text(story.title)
                        .font(.title)
                        .bold()
                        .padding(.bottom, 5)

                    Text(story.body)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(8)
                        .padding(.bottom, 10)
                    // Should only execute with
                    if(paths != nil) {
                        NavigationLink(destination: StoryTwistsView(paths: paths!)) {
                                if(isloading) {
                                    ProgressView()
                                }
                                Text("View Twists")
                                    .foregroundColor(.blue)
                                    .font(.headline)
                        }
                    }else{
                        Text("No Twists").font(.headline)
                    }
                }
                .padding()
            }.onAppear() {
                isloading = true
                getTwist(hashId:story.hashID) { result in
                    paths = result
                    isloading = false
                }
            }
            .navigationTitle(story.title)
        }
    }
}

struct StoryTwistsView: View {
    var paths:StoryWithTwist
    
    var body: some View {
        List {
            ForEach(paths.path!, id: \.title) { twist in
                NavigationLink(destination: UserTwistDetailView(userTwist: twist)) {
                    Text(twist.title ?? "")
                }
            }
        }
        .navigationTitle("Twists by Users")
    }
}

struct UserTwistDetailView: View {
    let userTwist:Path  // Assuming you have a UserTwist model
    
    init(userTwist: Path) {
        self.userTwist = userTwist
    }
    //print("Story View")
    //getTwist(hashId:story.hashID) { result in
    //    print(result)
    //}
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(userTwist.title ?? "")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 5)

                Text(userTwist.body ?? "")
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(8)
                    .padding(.bottom, 10)

                // Add other details you want to display for the user twist
            }
            .padding()
        }
        .navigationTitle(userTwist.title ?? "")
    }
}



struct ReadStoryView_Previews: PreviewProvider {
    static var previews: some View {
        ReadStoryView(story: Story(
            title: "The Misty Meadows Quest: ChaCha and Silver's Friendship Adventures", hashID: "adegAJ1127JOMbNl",
            body: "In the whimsical land of Toad Hollow, where the fog danced among the lily pads and the croaking of frogs created a symphony of nature, there lived a graceful horse named ChaCha and a spirited little pony named Silver. The duo were inseparable friends, known for their laughter that echoed through the misty meadows that laid beyond.\n\nOne misty morning, as ChaCha and Silver frolicked by the glistening pond, they stumbled upon a mysterious path that forked in three different directions. The enchanted Toad Sage had once told them that this path led to different adventures, and only the choices made by true friends would decide where their journey would take them.",
            updatedAt: "2024-01-13T06:38:06.411Z",
            tags: ["Adventure", "Children's Books", "Fantasy", "Friendship", "Tales"],
            isDeletable: true,
            status: "declined",
            views: 1,
            summary: "chacha_and_silver_two_inseparable_friends_in_toad_hollow_embarking_on_a_mysterious_journey"
        ))
    }
}
