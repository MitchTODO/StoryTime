//
//  StoryTwist.swift
//  StoryTime
//
//  Created by mitchell tucker on 1/22/24.
//

import SwiftUI

struct CreateTwistView: View {
    var storyHashId:String
    @State private var twistTitle = ""
    @State private var twistBody = ""
    @State private var twistTags = ""
    @State private var twistSummary = ""

    @State private var isLoading = false
    var body: some View {

            Form {
                Section(header: Text("Twist Details")) {
                    TextField("Twist Title", text: $twistTitle)
                    TextEditor(text: $twistBody)
                                        .frame(minHeight: 100, maxHeight: .infinity) // Adjust the height as needed
                                    
                    TextField("Twist Tags (comma-separated)", text: $twistTags)
                    TextField("Twist Summary", text: $twistSummary)
                }

                Section {
                    Button(action: createTwist) {
                        Text("Create Twist")
                    }.disabled(twistTitle.isEmpty || twistBody.isEmpty)
                }
            }
            .disabled(isLoading)
            .navigationTitle("Create Twist")
            .navigationBarItems(trailing: Button("Cancel") {
                // Handle cancel action
            })
        
    }

    func createTwist() {

        isLoading = true
        //print("Twist Tags: \(twistTags)")
        //print("Twist Summary: \(twistSummary)")
        postTwist(hashParentId: storyHashId, title: twistTitle, body: twistBody) { result in
            isLoading = false
        }
    }
}

struct CreateTwistView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTwistView(storyHashId: "Test")
    }
}
