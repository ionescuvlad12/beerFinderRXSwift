import Foundation
import Domain
import RxSwift
import RxCocoa

final class BeersViewModel: ViewModelType {
   
    struct Input {
        let trigger: Driver<Void>

    }
    struct Output {
        let fetching: Driver<Bool>
        let sortBeer: Driver<Bool>
        let beers: Driver<[BeerItemViewModel]>
        let error: Driver<Error>
    }

    private let useCase: BeersUseCase
    private let navigator: BeersNavigator
    
    init(useCase: BeersUseCase, navigator: BeersNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let beers = input.trigger.flatMapLatest {
            return self.useCase.beers()
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
                .map { $0.map { BeerItemViewModel(with: $0) } }
        }
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        let sortBeer = activityIndicator.asDriver()
        return Output(fetching: fetching,
                      sortBeer: sortBeer,
                      beers: beers,
                      error: errors)
    }
    
    func sort(input: Input?, ascending:Bool) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let beers = self.useCase.sortBeers(ascending: ascending)
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
                .map { $0.map { BeerItemViewModel(with: $0) } }
        
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        let sortBeer = activityIndicator.asDriver()
        return Output(fetching: fetching,
                      sortBeer: sortBeer,
                      beers: beers,
                      error: errors)
    }
    
    func beerByFood(input: Input?, food:String) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let beers =  self.useCase.beersByFood(food: food)
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
                .map { $0.map { BeerItemViewModel(with: $0) } }
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        let sortBeer = activityIndicator.asDriver()
        return Output(fetching: fetching, sortBeer: sortBeer,
                      beers: beers,
                      error: errors)
    }
    
    
}
