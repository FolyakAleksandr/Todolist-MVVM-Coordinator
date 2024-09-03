import UIKit

final class TodolistView: UIViewController {
    // MARK: - public variables

    public var viewModel: TodolistViewModel?
    public var todosArray: [DataItem] = [] {
        didSet {
            listTableView.reloadData()
        }
    }
    
    // MARK: - private properties
    
    private let listTableView = UITableView()
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchItems()
        updateListTableView()
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
        listTableView.register(TodolistCell.self, forCellReuseIdentifier: "TodolistCell")
        listTableView.separatorStyle = .none
    }
    
    private func configureNavigationController() {
        navigationController?.setCustomAppearance(titleColor: .black, backgroundColor: .systemGray5)
        title = "To Do List"
    }
    
    private func fetchItems() {
        viewModel?.fetchTodos()
    }
    
    private func updateListTableView() {
        viewModel?.didUpdateTodos = { array in
            self.todosArray = array
        }
    }
}

// MARK: - extension

extension TodolistView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodolistCell", for: indexPath) as? TodolistCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        let viewModel = DefaultTodolistViewModel()
        cell.delegateTapped = { view, imageView, button in
            viewModel.selectedButtonTapped(view: view, imageView: imageView, button: button)
        }
        
        cell.delegateLoading = { view, imageView, button in
            if self.todosArray[indexPath.row].completed {
                viewModel.loadCompletedTask(view: view, imageView: imageView, button: button)
                viewModel.isSelected = true
            } else {
                viewModel.loadNotCompletedTask(view: view, imageView: imageView, button: button)
                viewModel.isSelected = false
            }
        }
        
        cell.configureCell(todosArray[indexPath.row].todo, nil, Date(), todosArray[indexPath.row].completed)
        
        return cell
    }
}
