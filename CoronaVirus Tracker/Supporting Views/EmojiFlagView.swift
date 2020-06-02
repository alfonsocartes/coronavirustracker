//
//  EmojiFlagView.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 31/01/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

import SwiftUI

struct EmojiFlagView: View {
    
    var country : String
    
    var body: some View {
        VStack {
            Text("\(emojiFlag(regionCode: localeForCountry(country: country) ?? "") ?? "")")
                .font(.largeTitle)
        }
        //.frame(width: 100, height: 100)
    }

    
    func emojiFlag(regionCode: String) -> String? {
        let code = regionCode.uppercased()

        guard Locale.isoRegionCodes.contains(code) else {
            return nil
        }

        var flagString = ""
        for s in code.unicodeScalars {
            guard let scalar = UnicodeScalar(127397 + s.value) else {
                continue
            }
            flagString.append(String(scalar))
        }
        return flagString
    }
    
    func localeForCountry(country : String) -> String?
    {
        var countryName = country
        
        switch country {
        case "Mainland China":
            countryName = "China mainland"
        case "US":
           countryName = "United States"
        case "UK":
            countryName = "United Kingdom"
        case "Macau":
            countryName = "Macao"
        default:
          countryName =  country
        }
        
        return NSLocale.isoCountryCodes.first { self.countryNameFromLocaleCode(localeCode: $0 ) == countryName}
    }
    
    func countryNameFromLocaleCode(localeCode : String) -> String
    {
        return NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.countryCode, value: localeCode) ?? ""
    }
    
    func locale(for fullCountryName : String) -> String {
        let locales : String = ""
        for localeCode in NSLocale.isoCountryCodes {
            let identifier = NSLocale(localeIdentifier: localeCode)
            let countryName = identifier.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
            if fullCountryName.lowercased() == countryName?.lowercased() {
                return localeCode
            }
        }
        return locales
    }
}

struct EmojiFlagView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiFlagView(country: "UK")
    }
}
