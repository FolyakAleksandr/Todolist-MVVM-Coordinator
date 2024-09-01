import UIKit
protocol TodolistViewModel: AnyObject {
    func selectedButtonTapped(view: UIView, imageView: UIImageView, button: UIButton)
    var isSelected: Bool { get set }
}

final class DefaultTodolistViewModel: TodolistViewModel {
    var isSelected: Bool = false

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
}
