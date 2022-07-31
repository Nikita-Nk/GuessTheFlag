import UIKit
import SDWebImage

final class FlagsManager {

    public static let shared = FlagsManager()
    
    private let endpoint = "https://countryflagsapi.com/png/"
    
    // Country Name: UN Code
    private var countriesDictionary: [String: String] = ["United Arab Emirates": "784",
                                                 "Andorra": "020",
                                                 "Armenia": "051",
                                                 "Argentina": "032",
                                                 "Austria": "040",
                                                 "Australia": "036",
                                                 "Belgium": "056",
                                                 "Belarus": "112",
                                                 "Canada": "124",
                                                 "Cyprus": "196",
                                                 "Germany": "276",
                                                 "Estonia": "233",
                                                 "Egypt": "818",
                                                 "Spain": "724",
                                                 "Finland": "246",
                                                 "France": "250",
                                                 "UK": "826",
                                                 "Gibraltar": "292",
                                                 "Guadeloupe": "312",
                                                 "Greece": "300",
                                                 "Hong Kong": "344",
                                                 "Croatia": "191",
                                                 "Honduras": "340",
                                                 "Ireland": "372",
                                                 "Israel": "376",
                                                 "Italy": "380",
                                                 "Netherlands": "528",
                                                 "Norway": "578",
                                                 "New Zealand": "554",
                                                 "Poland": "616",
                                                 "Sweden": "752",
                                                 "Singapore": "702"]
    private var threeCountries = [(country: String, unCode: String)]()
    private var isContainsFlag = false
    var correctAnswer = 0
    
    func newFlags(completionHandler: @escaping ([URL], String) -> Void) {
        
        threeCountries.removeAll()
        
        while threeCountries.count < 3 {
            
            isContainsFlag = false
            let randomElement = countriesDictionary.randomElement()!
            let tuple = (country: randomElement.key, unCode: randomElement.value)
            
            for element in threeCountries {
                if tuple == element {
                    isContainsFlag = true
                }
            }
            
            if !isContainsFlag {
                threeCountries.append(tuple)
            }
        }
        
        correctAnswer = Int.random(in: 0...2)
        let title = threeCountries[correctAnswer].country.uppercased()
        
        // SDWebImage
        var threeCountriesUrl = [URL]()
        for country in threeCountries {
            
            let unCode = country.unCode
            let imageUrl = endpoint + unCode
            guard let url = URL(string: imageUrl) else { return }
            threeCountriesUrl.append(url)
        }
        completionHandler(threeCountriesUrl, title)
    }
}
