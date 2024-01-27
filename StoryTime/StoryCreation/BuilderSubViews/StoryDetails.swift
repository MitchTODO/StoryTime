//
//  StoryDetails.swift
//  StoryTime
//
//  Created by mitchell tucker on 1/16/24.
//

import SwiftUI

struct StoryDetails: View {
    @EnvironmentObject var storyBuilderVM:StoryBuilderViewModel
    
    var body: some View {
        VStack {
            Text("Your Story Details")
                .font(.title2)
                .padding()
            HStack {
                Button(action: {}, label: {
                    HStack{
                        Text("Genres").bold()
                        Spacer()
                    }
                })
                Text(storyBuilderVM.selectGenres)
            }

            HStack{
                Button(action: {}, label: {
                    HStack{
                        Text("Length").bold()
                        Spacer()
                    }
                })
                //Text("\(storyBuilderVM.time) Minutes")
            }

            Button(action: {}, label: {
                HStack{
                    Text("Themes").bold()
                    Spacer()
                }
      
            })

            ForEach(Array(storyBuilderVM.selectedThemes.keys), id: \.self) { theme in
                Text(theme)
            }
      
            Button(action: {}, label: {
                HStack{
                    Text("Charaters").bold()
                    Spacer()
                }
                
            })
       
            HStack{
                VStack{
                    Text("Protagonist").bold()
                    Text(storyBuilderVM.protagonist)
                }
                VStack{
                    Text("Antagonist").bold()
                    Text(storyBuilderVM.antagonist)
                }
                VStack{
                    Text("SideKick").bold()
                    Text(storyBuilderVM.sidekick)
                }
            }
            
            HStack{
                VStack{
                    Text("Confidante").bold()
                    Text(storyBuilderVM.confidante)
                }

            }
            
            Button(action: {}, label: {
                HStack{
                    Text("Scene").bold()
                    Spacer()
                }
            })
            
            HStack {
                VStack{
                    Text("Landscape").bold()
                    Text(storyBuilderVM.location)
                }
                
                VStack{
                    Text("Weather").bold()
                    Text(storyBuilderVM.weather)
                }
                VStack {
                    Text("Season").bold()
                    Text(storyBuilderVM.season)
                }

            }
            
            Spacer()
            Button(action: {
                // change story state to wait for open ai results
                storyBuilderVM.storyState = .storyOverView
                // generating story
                storyBuilderVM.generateStory()
  
            }, label: {
                Text("Generate Story")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                
            }).frame(height: 50)
                .frame(maxWidth: .infinity) // how to make a button fill all the space available horizontaly
                .background(
                    
                        LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .cornerRadius(20)
                .padding()

        }
    }
}

#Preview {
    StoryDetails().environmentObject(StoryBuilderViewModel())
}
