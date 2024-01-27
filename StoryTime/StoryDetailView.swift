//
//  StoryDetailView.swift
//  StoryTime
//
//  Created by mitchell tucker on 1/21/24.
//

import SwiftUI

struct StoryDetailView: View {
    var story: Story
    init(story: Story) {
        self.story = story
        if story.title.isEmpty {
            self.story.title = "Untitled"
        }
   
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(story.title)
                    .font(.title)
                    .bold()
                    .padding(.bottom, 5)

                Text("Summary: \(story.summary ?? " ")")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)

                NavigationLink(destination: ReadStoryView(story: story)) {
                    Image(systemName: "book.fill")
                }
                
                Text("\(story.body)")
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(5)
                    .padding(.bottom, 10)
                
   

                Text("Tags: \(story.tags.joined(separator: ", "))")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .padding(.bottom, 10)

                HStack {
                    Text("Upload Status: \(story.status)")
                        .font(.subheadline)
                        .foregroundColor(story.status == "approved" ? .green : .red)

                    Spacer()

                    Text("Views: \(story.views)")
                        .font(.subheadline)
                }
                .padding(.bottom, 10)

                Text("Last Updated: \(formatDate(story.updatedAt))")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Button(action: {}, label: {Text("Delete")})
            }
            .padding()
        }

        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: CreateTwistView(storyHashId: story.hashID)) {
                    Text("+ Twist")
                }
            }
        }
    }

    func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
            return dateFormatter.string(from: date)
        }

        return dateString
    }
}

struct StoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleStory = Story(
            title: "The Misty Meadows Quest: ChaCha and Silver's Friendship Adventures", hashID: "adegAJ1127JOMbNl",
            body: "In the whimsical land of Toad Hollow, where the fog danced among the lily pads and the croaking of frogs created a symphony of nature, there lived a graceful horse named ChaCha and a spirited little pony named Silver. The duo were inseparable friends, known for their laughter that echoed through the misty meadows that laid beyond.\n\nOne misty morning, as ChaCha and Silver frolicked by the glistening pond, they stumbled upon a mysterious path that forked in three different directions. The enchanted Toad Sage had once told them that this path led to different adventures, and only the choices made by true friends would decide where their journey would take them.",
            updatedAt: "2024-01-13T06:38:06.411Z",
            tags: ["Adventure", "Children's Books", "Fantasy", "Friendship", "Tales"],
            isDeletable: true,
            status: "declined",
            views: 1,
            summary: "chacha_and_silver_two_inseparable_friends_in_toad_hollow_embarking_on_a_mysterious_journey"
        )

        StoryDetailView(story: sampleStory)
    }
}
