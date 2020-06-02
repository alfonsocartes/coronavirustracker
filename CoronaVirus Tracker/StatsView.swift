//
//  StatsView.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 01/02/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

import SwiftUI

struct StatsView: View {
    
    @Binding var placemarks: [Placemark]
    @Binding var totalConfirmed: Int
    @Binding var totalDeaths: Int
    @Binding var totalRecovered: Int
    
    @State private var showPopUp = false
    @State private var showRefreshAlert = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    VStack {
                        VStack {
                            Text("Novel Coronavirus")
                                .font(.largeTitle)
                            Text("(2019-nCoV)")
                                .font(.title)
                        }
                        .padding(.top, geometry.size.height / 15)
                        .frame(width: geometry.size.width)
                        Button(action: {
                            self.showPopUp = true
                        }) {
                            CircleImage(image: Image(imageData[0].imageName))
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding()
                        .accessibility(hidden: true)
                        if self.sizeClass == .compact {
                            VStack {
                                HStack {
                                    Text("Total infected:")
                                    Spacer()
                                    Text("\(self.totalConfirmed)")
                                }
                                HStack {
                                    Text("Total cured:")
                                    Spacer()
                                    Text("\(self.totalRecovered)")
                                }
                                HStack {
                                    Text("Total deaths:")
                                    Spacer()
                                    Text("\(self.totalDeaths)")
                                }
                            }
                            .padding(.horizontal, geometry.size.width * 0.1)
                            .font(.title)
                        } else {
                            VStack (alignment: .leading) {
                                Text("Total infected: \(self.totalConfirmed)")
                                Text("Total cured: \(self.totalRecovered)")
                                Text("Total deaths: \(self.totalDeaths)")
                            }
                            .padding(.horizontal, geometry.size.width * 0.1)
                            .font(.title)
                        }
                        NavigationLink(destination: RecommendationsView()) {
                            HStack {
                                Image(systemName: "heart.fill")
                                    .font(.headline)
                                Text("Recommendations")
                                    .fontWeight(.bold)
                                    .font(.headline)
                            }
                            .frame(minWidth: 0, maxWidth: 200)
                            .padding(10)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(40)
                            .padding(.horizontal, 20)
                        }
                        .padding(.bottom, 5)
                        
                    }
                    .sheet(isPresented: self.$showPopUp) {
                        VStack {
                            HStack {
                                Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                                    Handle()
                                }
                                .padding()
                            }
                            ImagePopUpView(image: Image(imageData[0].imageName),
                                           imageCredits: imageData[0].imageCredits,
                                           imageURL: imageData[0].imageURL)
                            
                        }
                    }
                    .alert(isPresented: self.$showRefreshAlert) {
                        Alert(title: Text("No updates avalable"),
                              message: Text("There are no updates avilable yet. Please stay tuned."))
                    }
                }
            }
            HStack {
                Text("Last update: \(self.placemarks.first?.place.LastUpdate ?? "Not updated")")
                    .font(.caption)
                Button(action: {
                    let lastUpdateOld = self.placemarks.first?.place.LastUpdate
                    self.placemarks = generatePlacemarks()
                    let lastUpdateNew = self.placemarks.first?.place.LastUpdate
                    if lastUpdateOld == lastUpdateNew {
                        self.showRefreshAlert = true
                    }
                }) {
                    Image(systemName: "arrow.2.circlepath")
                        .font(.caption)
                }
            }
            .padding(.bottom, 5)
            BannerView()
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(placemarks: .constant([Placemark.example1]),
                  totalConfirmed: .constant(1000),
                  totalDeaths: .constant(1),
                  totalRecovered: .constant(100))
    }
}
