import Foundation
import Domain
import RxSwift

final class BeersUseCase<Cache>: Domain.BeersUseCase where Cache: AbstractCache, Cache.T == Beer {
    
 
    private let network: BeersNetwork
    private let cache: Cache

    init(network: BeersNetwork, cache: Cache) {
        self.network = network
        self.cache = cache
    }

    func beers() -> Observable<[Beer]> {
        let fetchBeers = cache.fetchObjects().asObservable()
        let stored = network.fetchBeers()
            .flatMap {
                return self.cache.save(objects: $0)
                    .asObservable()
                    .map(to: [Beer].self)
                    .concat(Observable.just($0))
            }
        
        return fetchBeers.concat(stored)
    }
    
     func beersByFood(food: String) -> Observable<[Beer]> {
        let fetchBeers = cache.fetchObjects().asObservable()
        let stored = network.fetchBeer(food: food)
            .flatMap {
                return self.cache.save(objects: $0)
                    .asObservable()
                    .map(to: [Beer].self)
                    .concat(Observable.just($0))
        }
        
        return fetchBeers.concat(stored)
    }
    
    func sortBeers(ascending:Bool) -> Observable<[Beer]> {
        let compareRes = ascending ? ComparisonResult.orderedAscending : ComparisonResult.orderedDescending
        return self.beers()
            .map { results -> [Beer] in
                let sortedBeer = results
                    .sorted(by: { $0.abv.compare($1.abv) == compareRes })
                return sortedBeer
        }
    }
}

struct MapFromNever: Error {}
extension ObservableType where E == Never {
    func map<T>(to: T.Type) -> Observable<T> {
        return self.flatMap { _ in
            return Observable<T>.error(MapFromNever())
        }
    }
}
