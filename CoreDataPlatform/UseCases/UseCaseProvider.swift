import Foundation
import Domain

public final class UseCaseProvider: Domain.UseCaseProvider {
    private let coreDataStack = CoreDataStack()
    private let beerRepository: Repository<Beer>

    public init() {
        beerRepository = Repository<Beer>(context: coreDataStack.context)
    }

    public func makeBeersUseCase() -> Domain.BeersUseCase {
        return BeersUseCase(repository: beerRepository)
    }
}
