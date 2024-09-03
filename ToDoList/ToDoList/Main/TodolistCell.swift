import UIKit

final class TodolistCell: UITableViewCell {
    // MARK: - public variables

    var viewModel: TodolistViewModel?
    var delegateTapped: ((UIView, UIImageView, UIButton) -> Void)?
    var delegateLoading: ((UIView, UIImageView, UIButton) -> Void)?
    
    // MARK: - private properties

    private let containerView = UIView()
    private let nameTaskLabel = UILabel()
    private let descriptionTaskLabel = UILabel()
    private let selectedButton = UIButton()
    private let selectedImageView = UIImageView()
    private let dateLabel = UILabel()
    private let dateFormatter = DateFormatter()

    // MARK: - initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        self.backgroundColor = .systemGray5
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeViewRound()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - setup UI

    private func setupUI() {
        layoutContainerView()
        configureContainerView()

        layoutNameTaskLabel()
        configureNameTaskLabel()
        
        layoutDescriptionTaskLabel()
        configureDescriptionTaskLabel()
        
        layoutSelectedButton()
        configureSelectedButton()
        
        layoutSelectedImageView()
        configureSelectedImageView()
        
        layoutDateLabel()
        configureDateLabel()
    }

    private func layoutContainerView() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
    }

    private func configureContainerView() {
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 7
    }
    
    private func selectedBorderForContainerView() {
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor.systemGreen.cgColor
        containerView.layer.shadowColor = UIColor.systemGreen.cgColor
        containerView.layer.shadowRadius = 7
        containerView.layer.shadowOpacity = 0.7
        containerView.layer.shadowOffset = .init(width: 0, height: 0)
    }
    
    private func defaultBorderForContainerView() {
        containerView.layer.borderWidth = 0
        containerView.layer.shadowColor = UIColor.clear.cgColor
    }

    private func layoutNameTaskLabel() {
        containerView.addSubview(nameTaskLabel)
        nameTaskLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameTaskLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12).isActive = true
        nameTaskLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12).isActive = true
        nameTaskLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.85).isActive = true
    }

    private func configureNameTaskLabel() {
        nameTaskLabel.font = .systemFont(ofSize: 20, weight: .bold)
        nameTaskLabel.textColor = .black
        nameTaskLabel.numberOfLines = 2
    }
    
    private func layoutDescriptionTaskLabel() {
        containerView.addSubview(descriptionTaskLabel)
        descriptionTaskLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionTaskLabel.topAnchor.constraint(equalTo: nameTaskLabel.bottomAnchor, constant: 12).isActive = true
        descriptionTaskLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12).isActive = true
        descriptionTaskLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.9).isActive = true
    }
    
    private func configureDescriptionTaskLabel() {
        descriptionTaskLabel.font = .systemFont(ofSize: 18, weight: .light)
        descriptionTaskLabel.textColor = .darkGray
        descriptionTaskLabel.numberOfLines = 2
    }
    
    private func layoutSelectedButton() {
        contentView.addSubview(selectedButton)
        selectedButton.translatesAutoresizingMaskIntoConstraints = false
        
        selectedButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12).isActive = true
        selectedButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12).isActive = true
        selectedButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.07).isActive = true
        selectedButton.heightAnchor.constraint(equalTo: selectedButton.widthAnchor, multiplier: 1).isActive = true
    }
    
    private func configureSelectedButton() {
        selectedButton.layer.borderColor = UIColor.black.cgColor
        selectedButton.layer.borderWidth = 0.5
        selectedButton.addTarget(self, action: #selector(selectedTapped), for: .touchUpInside)
    }
    
    private func layoutSelectedImageView() {
        selectedButton.addSubview(selectedImageView)
        selectedImageView.translatesAutoresizingMaskIntoConstraints = false
        
        selectedImageView.topAnchor.constraint(equalTo: selectedButton.topAnchor, constant: -3).isActive = true
        selectedImageView.bottomAnchor.constraint(equalTo: selectedButton.bottomAnchor, constant: 3).isActive = true
        selectedImageView.leadingAnchor.constraint(equalTo: selectedButton.leadingAnchor, constant: -3).isActive = true
        selectedImageView.trailingAnchor.constraint(equalTo: selectedButton.trailingAnchor, constant: 3).isActive = true
    }
    
    private func configureSelectedImageView() {
        selectedImageView.image = UIImage(systemName: "checkmark.circle.fill")
        selectedImageView.tintColor = .systemGreen
    }
    
    private func layoutDateLabel() {
        containerView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.topAnchor.constraint(equalTo: descriptionTaskLabel.bottomAnchor, constant: 12).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: descriptionTaskLabel.leadingAnchor, constant: 0).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12).isActive = true
    }
    
    private func configureDateLabel() {
        dateFormatter.dateFormat = "dd.MM.yyyy  HH:mm"
        dateLabel.textColor = .darkGray
        dateLabel.font = .systemFont(ofSize: 17, weight: .light)
    }
    
    private func makeViewRound() {
        selectedButton.layoutIfNeeded()
        selectedButton.layer.cornerRadius = selectedButton.frame.size.height / 2
    }
    
    // MARK: - objc methods
    
    @objc private func selectedTapped() {
        delegateTapped?(containerView, selectedImageView, selectedButton)
    }
    
    // MARK: - configure
    
    func configureCell(_ nameTask: String, _ descriptionTask: String?, _ date: Date, _ completed: Bool) {
        nameTaskLabel.text = nameTask
        descriptionTaskLabel.text = descriptionTask ?? "No description"
        dateLabel.text = dateFormatter.string(from: date)
        delegateLoading?(containerView, selectedImageView, selectedButton)
    }
}
