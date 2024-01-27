//
//  StoryBackground.swift
//  StoryTime
//
//  Created by mitchell tucker on 1/20/24.
//

import SwiftUI

struct StoryBackground: View {
    
    @EnvironmentObject var storyBuilderVM:StoryBuilderViewModel
    
    let locations:[String] = ["Mountain","Desert","Coastal","Forest","Grassland","Urban","Volcanic"]
    let weather:[String] = ["Sunny", "Rainy", "Snowy", "Stormy", "Foggy", "Windy"]
    let season:[String] = ["Summer","Fall","Winter","Spring"]
    
    
    var body: some View {
        VStack {
            Text("Set the scene!")
                .font(.title2)
            Spacer()
            VStack(alignment: .leading) {
                    Section("Geography") {
                        LazyVGrid(columns:  Array(repeating: GridItem(), count: 2), spacing: 10, content: {
                            ForEach(locations,id:\.self) { type in
                                Button(action: {
                                    storyBuilderVM.location = type
                                }, label: {
                                    HStack {
                                        Text(type)
                                        if(storyBuilderVM.location == type) {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.blue)
                                        }
                                    }
                                }).buttonStyle(.bordered)
                            }
                        })
                    }
                Section("Weather") {
                    LazyVGrid(columns:  Array(repeating: GridItem(), count: 2), spacing: 10, content: {
                        ForEach(weather,id:\.self) { type in
                            Button(action: {
                                storyBuilderVM.weather = type
                            }, label: {
                                HStack {
                                    Text(type)
                                   
                                    if(storyBuilderVM.weather == type) {
                                        Image(systemName: "checkmark")
                                            
                                            .foregroundColor(.blue)
                                    }
                                }
                            }).buttonStyle(.bordered)
                        }
                    })
                }
                
                Section("Seasons") {
                    LazyVGrid(columns:  Array(repeating: GridItem(), count: 2), spacing: 10, content: {
                        ForEach(season,id:\.self) { type in
                            Button(action: {
                                storyBuilderVM.season = type
                            }, label: {
                                HStack {
                                    Text(type)
                                    Spacer()
                                    if(storyBuilderVM.season == type) {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.blue)
                                    }
                                }
                            }).buttonStyle(.bordered)
                        }
                    })
                }
            }.padding()
            Spacer()
            Button(action: {
                storyBuilderVM.storyState = .finish
            }, label: {
                Text("Done")
            }).disabled(storyBuilderVM.season.isEmpty || storyBuilderVM.weather.isEmpty || storyBuilderVM.location.isEmpty)
                .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    StoryBackground().environmentObject(StoryBuilderViewModel())
}
