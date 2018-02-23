import Foundation
import Domain
import NetworkPlatform
import CoreDataPlatform


final class Application {
    static let shared = Application()

    private let coreDataUseCaseProvider: Domain.UseCaseProvider
    private let networkUseCaseProvider: Domain.UseCaseProvider

    private init() {
        self.coreDataUseCaseProvider = CoreDataPlatform.UseCaseProvider()
        self.networkUseCaseProvider = NetworkPlatform.UseCaseProvider()
    }

    func configureMainInterface(in window: UIWindow) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let networkNavigationController = UINavigationController()
        networkNavigationController.tabBarItem = UITabBarItem(title: "Beers",
                image: UIImage(named: "6597-200"),
                selectedImage: nil)
        let networkNavigator = DefaultBeersNavigator(services: networkUseCaseProvider,
                navigationController: networkNavigationController,
                storyBoard: storyboard)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
                networkNavigationController
        ]
        window.rootViewController = tabBarController

        networkNavigator.toBeers()
    }
}
