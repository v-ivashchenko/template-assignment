//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import UIKit

class TopRatedMoviesViewController: UIViewController {

    // MARK: - Private properties
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTableView()
    }
    
    // MARK: - Private methods
    private func configureView() {
        title = "Top Rated Movies"
        view.backgroundColor = .systemBackground
        
        refreshControl.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        tableView.register(TopRatedMoviesCell.self, forCellReuseIdentifier: TopRatedMoviesCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    // MARK: - IBActions
    @objc private func refreshControlValueChanged(sender: UIRefreshControl) {
        
    }
}

// MARK: - UITableViewDataSource
extension TopRatedMoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopRatedMoviesCell.reuseIdentifier, for: indexPath) as! TopRatedMoviesCell
        
        cell.configure(with: .init(title: "Title", imagePath: "", rating: 5))
        
        return cell
    }
}
