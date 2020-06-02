//
//  BannerView.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 06/02/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//


import SwiftUI
import GoogleMobileAds
import UIKit

final private class BannerVC: UIViewControllerRepresentable  {
    
    private let bannerID = "ca-app-pub-7295318534750267~1905294569"
    private let bannerIDTEST = "ca-app-pub-3940256099942544/2934735716"
    
    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: kGADAdSizeBanner)
        
        
        let viewController = UIViewController()
        
        view.adUnitID = bannerID
        //view.adUnitID = bannerIDTEST
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeBanner.size)
        view.load(GADRequest())
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct BannerView:View{
    var body: some View{
        HStack{
            Spacer()
            if UIDevice.current.userInterfaceIdiom == .pad {
                BannerVC().frame(width: 320, height: 100, alignment: .center)
            } else {
                BannerVC().frame(width: 320, height: 50, alignment: .center)
            }
            Spacer()
        }
    }
}

struct BannerView_Previews: PreviewProvider {
    static var previews: some View {
        BannerView()
    }
}
