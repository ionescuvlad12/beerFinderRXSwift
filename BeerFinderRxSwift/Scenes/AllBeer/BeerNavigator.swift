import UIKit
import Domain

protocol BeersNavigator {
    func toBeers()
}

class DefaultBeersNavigator: BeersNavigator {
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let services: UseCaseProvider

    init(services: UseCaseProvider,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.services = services
        self.navigationController = navigationController
        self.storyBoard = storyBoard
    }
    
    func toBeers() {
        let vc = storyBoard.instantiateViewController(ofType: BeersViewController.self)
        vc.viewModel = BeersViewModel(useCase: services.makeBeersUseCase(),
                                      navigator: self)
        navigationController.pushViewController(vc, animated: true)
    }
}
