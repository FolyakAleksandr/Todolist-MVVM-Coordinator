import UIKit

protocol AppCoordiantor {
    func start()
}

final class Coordinator: AppCoordiantor {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showMainScreen()
    }

    func showMainScreen() {
        let view = TodolistView()
        let viewModel = DefaultTodolistViewModel()
        view.viewModel = viewModel

        navigationController.pushViewController(view, animated: true)
    }
}
