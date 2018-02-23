import Foundation
import Domain
import RxSwift

final class BeersUseCase<Repository>: Domain.BeersUseCase where Repository: AbstractRepository, Repository.T == Beer {
    
    
    private let repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }

    func beers() -> Observable<[Beer]> {
        return repository.query(with: nil, sortDescriptors: [Beer.CoreDataType.abv.descending()])
    }
    
    
    func sortBeers(ascending: Bool) -> Observable<[Beer]> {
        if ascending {
           return repository.query(with: nil, sortDescriptors: [Beer.CoreDataType.abv.ascending()])
        } else {
            return repository.query(with: nil, sortDescriptors: [Beer.CoreDataType.abv.descending()])
        }
    }
    // TO DO
    func beersByFood(food: String) -> Observable<[Beer]> {
        return repository.query(with: nil, sortDescriptors: [Beer.CoreDataType.abv.ascending()])
    }
    
    
    func save(beers: Beer) -> Observable<Void> {
        return repository.save(entity: beers)
    }

    func delete(beer: Beer) -> Observable<Void> {
        return repository.delete(entity: beer)
    }
}
