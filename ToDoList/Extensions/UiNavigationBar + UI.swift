import UIKit

extension UINavigationController {
    func setCustomAppearance(titleColor: UIColor, backgroundColor: UIColor?) {
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        
        appearance.titleTextAttributes = [
            .foregroundColor: titleColor,
            .font: UIFont.systemFont(ofSize: 20, weight: .light)
        ]
        
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.compactAppearance = appearance
    }
    
    func addPlusButton(target: Any, action: Selector) {
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: target, action: action)
        self.navigationBar.topItem?.rightBarButtonItem = plusButton
    }
}
