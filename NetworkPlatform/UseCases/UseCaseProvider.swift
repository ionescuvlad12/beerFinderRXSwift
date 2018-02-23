import Foundation
import Domain

public final class UseCaseProvider: Domain.UseCaseProvider {
    private let networkProvider: NetworkProvider

    public init() {
        networkProvider = NetworkProvider()
    }

    public func makeBeersUseCase() -> Domain.BeersUseCase {
        return BeersUseCase(network: networkProvider.makeBeersNetwork(),
                               cache: Cache<Beer>(path: "beers"))
    }
}
