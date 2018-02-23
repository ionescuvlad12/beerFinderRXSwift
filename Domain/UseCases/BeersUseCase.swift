import Foundation
import RxSwift

public protocol BeersUseCase {
    func beers() -> Observable<[Beer]>
    func sortBeers(ascending: Bool) -> Observable<[Beer]>
    func beersByFood(food:String) -> Observable<[Beer]>
}
