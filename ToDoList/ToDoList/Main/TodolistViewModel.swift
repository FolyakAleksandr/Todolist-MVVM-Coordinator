import UIKit
protocol TodolistViewModel: AnyObject {
    func selectedButtonTapped(view: UIView, imageView: UIImageView, button: UIButton)
    func loadCompletedTask(view: UIView, imageView: UIImageView, button: UIButton)
    func loadNotCompletedTask(view: UIView, imageView: UIImageView, button: UIButton)
    func fetchTodos()

    var didUpdateTodos: (([DataItem]) -> Void)? { get set }
    var isSelected: Bool { get set }
}

final class DefaultTodolistViewModel: TodolistViewModel {
    var todosArray: [DataItem] = []
    var didUpdateTodos: (([DataItem]) -> Void)?
    var isSelected: Bool = false

    func fetchTodos() {
        NetworkManager.instance.getTodos { result in
            switch result {
            case .success(let fetchItems):
                self.todosArray = fetchItems
                self.didUpdateTodos?(fetchItems)
            case .failure(let failure):
                print(failure)
            }
        }
    }

    func selectedButtonTapped(view: UIView, imageView: UIImageView, button: UIButton) {
        if isSelected {
            view.layer.borderWidth = 0
            view.layer.shadowColor = UIColor.clear.cgColor
            imageView.isHidden = true
            button.layer.borderColor = UIColor.black.cgColor
            isSelected.toggle()
        } else {
            view.layer.borderWidth = 0.5
            view.layer.borderColor = UIColor.systemGreen.cgColor
            view.layer.shadowColor = UIColor.systemGreen.cgColor
            view.layer.shadowRadius = 7
            view.layer.shadowOpacity = 0.7
            view.layer.shadowOffset = .init(width: 0, height: 0)
            imageView.isHidden = false
            button.layer.borderColor = UIColor.clear.cgColor
            isSelected.toggle()
        }
    }

    func loadCompletedTask(view: UIView, imageView: UIImageView, button: UIButton) {
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.systemGreen.cgColor
        view.layer.shadowColor = UIColor.systemGreen.cgColor
        view.layer.shadowRadius = 7
        view.layer.shadowOpacity = 0.7
        view.layer.shadowOffset = .init(width: 0, height: 0)
        imageView.isHidden = false
        button.layer.borderColor = UIColor.clear.cgColor
    }

    func loadNotCompletedTask(view: UIView, imageView: UIImageView, button: UIButton) {
        view.layer.borderWidth = 0
        view.layer.shadowColor = UIColor.clear.cgColor
        imageView.isHidden = true
        button.layer.borderColor = UIColor.black.cgColor
    }
}
