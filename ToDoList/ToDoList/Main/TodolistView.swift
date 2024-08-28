import UIKit

final class TodolistView: UIViewController {
    // MARK: - public variables

    public var viewModel: TodolistViewModel?
    
    // MARK: - private properties
    
    private let listTableView = UITableView()
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: -  setup UI
    
    private func setupUI() {
        layoutListTableView()
        configureListTableView()
        setBackgroundView(color: .systemGray5)
        configureNavigationController()
    }
    
    private func layoutListTableView() {
        view.addSubview(listTableView)
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        
        listTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        listTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    private func configureListTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.showsVerticalScrollIndicator = false
        listTableView.backgroundColor = .systemGray5
    }
    
    private func configureNavigationController() {
        navigationController?.setCustomAppearance(titleColor: .black, backgroundColor: .systemGray5)
        title = "To Do List"
    }
}

// MARK: - extension

extension TodolistView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Int()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
