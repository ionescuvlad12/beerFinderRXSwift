import Foundation

public struct Beer {
    public let beerDescription: String
    public let name: String
    public let imgURL: String
    public let tagline: String
    public let abv: NSNumber

    public init(beerDescription: String,
                name: String,
                imgURL: String,
                tagline: String,
                abv: NSNumber) {
        self.beerDescription = beerDescription
        self.name = name
        self.imgURL = imgURL
        self.tagline = tagline
        self.abv = abv
    }

    public init(beerDescription: String, name: String) {
        self.init(beerDescription: beerDescription, name: name, imgURL: "", tagline: "5", abv: NSNumber())
    }
     init(beer:Beer) {
        self = beer
    }
}

extension Beer: Equatable {
    public static func == (lhs: Beer, rhs: Beer) -> Bool {
            return lhs.imgURL == rhs.imgURL &&
                lhs.name == rhs.name &&
                lhs.beerDescription == rhs.beerDescription &&
                lhs.tagline == rhs.tagline &&
                lhs.abv.isEqual(to: rhs.abv)
    }
}
