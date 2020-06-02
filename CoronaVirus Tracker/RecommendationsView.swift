//
//  RecommendationsView.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 01/02/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

import SwiftUI

struct RecommendationsView: View {
    
    @State private var showPopUp = false
    @State private var showingProtectionSheet = false
    @State private var showingFoodSheet = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    VStack (alignment: .leading){
                        Button(action: {
                            self.showPopUp = true
                        }) {
                            Image("symptoms")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.9)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(radius: 5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20).stroke(Color(.white), lineWidth: 4))
                                
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding()
                        .accessibility(hidden: true)
                        .sheet(isPresented: self.$showPopUp) {
                            VStack {
                                HStack {
                                    Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                                        Handle()
                                    }
                                    .padding()
                                }
                                ImagePopUpView(image: Image("symptoms"),
                                               imageCredits: "By Mikael Häggström, M.D. CC0",
                                               imageURL: "https://commons.wikimedia.org/w/index.php?curid=86352225")
                                
                            }
                        }
                    }
                    .padding(.top, 40)
                    VStack {
                        Button(action: {
                            self.showingProtectionSheet = true
                        }) {
                            HStack {
                                Image(systemName: "bandage.fill")
                                    .font(.headline)
                                Text("Protection")
                                    .fontWeight(.bold)
                                    .font(.headline)
                            }
                            .frame(minWidth: 0, maxWidth: 250)
                            .padding(10)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(40)
                            .padding(.horizontal, 20)
                        }
                        .sheet(isPresented: self.$showingProtectionSheet) {
                            VStack {
                                HStack {
                                    Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                                        Handle()
                                    }
                                    .padding()
                                }
                                Protection()
                            }
                        }
                    }
                    VStack {
                        Button(action: {
                            self.showingFoodSheet = true
                        }) {
                            HStack {
                                Image(systemName: "smiley.fill")
                                    .font(.headline)
                                Text("Food")
                                    .fontWeight(.bold)
                                    .font(.headline)
                            }
                            .frame(minWidth: 0, maxWidth: 250)
                            .padding(10)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(40)
                            .padding(.horizontal, 20)
                        }
                        .sheet(isPresented: self.$showingFoodSheet) {
                            VStack {
                                HStack {
                                    Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                                        Handle()
                                    }
                                    .padding()
                                }
                                Food()
                            }
                        }
                    }
                    VStack {
                        Advice()
                    }
                    
                }
            }
            BannerView()
        }
        .navigationBarTitle(Text("Recommendations"), displayMode: .large)
    }
    
    //Supporting views:
    
    struct Protection: View {
         var body: some View {
            VStack {
                GeometryReader { geometry in
                    ScrollView(.vertical) {
                        VStack {
                            Image("Protect1")
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .frame(width: geometry.size.width * 0.9)
                                .shadow(radius: 5)
                                .padding(.vertical)
                            Image("Protect2")
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .frame(width: geometry.size.width * 0.9)
                                .shadow(radius: 5)
                                .padding(.vertical)
                            Image("Protect3")
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .frame(width: geometry.size.width * 0.9)
                                .shadow(radius: 5)
                                .padding(.vertical)
                            Image("Protect4")
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .frame(width: geometry.size.width * 0.9)
                                .shadow(radius: 5)
                                .padding(.vertical)
                        }
                        VStack (alignment: .center) {
                            Button("More information") {
                                if let url = URL(string: "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public") {
                                    UIApplication.shared.open(url)
                                }
                            }
                        }
                        .padding(.top)
                    }
                }
            }
        }
    }
    
    struct Food: View {
         var body: some View {
            VStack {
                GeometryReader { geometry in
                    ScrollView(.vertical) {
                        VStack {
                            Image("Food1")
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .frame(width: geometry.size.width * 0.9)
                                .shadow(radius: 5)
                                .padding(.vertical)
                            Image("Food2")
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .frame(width: geometry.size.width * 0.9)
                                .shadow(radius: 5)
                                .padding(.vertical)
                            Image("Food3")
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .frame(width: geometry.size.width * 0.9)
                                .shadow(radius: 5)
                                .padding(.vertical)
                        }
                        VStack (alignment: .center) {
                            Button("More information") {
                                if let url = URL(string: "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public") {
                                    UIApplication.shared.open(url)
                                }
                            }
                        }
                        .padding(.top)
                    }
                }
            }
        }
    }
    
    
    struct Advice: View {
        
        private let recommendationsText =
         """
        WHO’s standard recommendations for the general public to reduce exposure to and transmission of a range of illnesses are as follows, which include hand and respiratory hygiene, and safe food practices:

        - Frequently clean hands by using alcohol-based hand rub or soap and water;
        - When coughing and sneezing cover mouth and nose with flexed elbow or tissue – throw tissue away immediately and wash hands;

        - Avoid close contact with anyone who has fever and cough;
        - If you have fever, cough and difficulty breathing seek medical care early and share previous travel history with your health care provider;

        - When visiting live markets in areas currently experiencing cases of novel coronavirus, avoid direct unprotected contact with live animals and surfaces in contact with animals;

        - The consumption of raw or undercooked animal products should be avoided. Raw meat, milk or animal organs should be handled with care, to avoid cross-contamination with uncooked foods, as per good food safety practices.
        """
        
         var body: some View {
            VStack {
                VStack (alignment: .leading) {
                    Text("WHO's advice for the public:")
                        .font(.headline)
                        .padding(.bottom)
                    Text(self.recommendationsText)
                    //Spacer()
                }
                VStack (alignment: .center) {
                    Button("More information") {
                        if let url = URL(string: "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public") {
                            UIApplication.shared.open(url)
                        }
                    }
                }
                .padding(.top, 30)
            }
            .padding()
        }
    }
}

struct RecommendationsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RecommendationsView()
            RecommendationsView.Protection()
            RecommendationsView.Food()
            RecommendationsView.Advice()
        }
    }
}
