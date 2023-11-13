//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import UIKit

class TopRatedMoviesViewController: UIViewController {
    
    // MARK: - Private properties
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let searchController = UISearchController()
    
    private let presenter: TopRatedMoviesPresenter
    
    // MARK: - Public properties
    var onSelectMovie: ((TopRatedMoviesCellViewModel) -> UIViewController)?
    
    // MARK: - Initialization
    init(presenter: TopRatedMoviesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTableView()
        loadMovies()
    }
    
    // MARK: - Private methods
    private func configureView() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        title = "Top Rated Movies"
        view.backgroundColor = .systemBackground
        
        refreshControl.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
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
    
    private func loadMovies() {
        presenter.loadMovies()
    }
    
    // MARK: - IBActions
    @objc private func refreshControlValueChanged(sender: UIRefreshControl) {
        presenter.loadMovies()
        searchController.isActive = false
    }
}

// MARK: - UISearchResultsUpdating
extension TopRatedMoviesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        presenter.filter(by: searchText)
    }
}

// MARK: - TopRatedMoviesViewProtocol
extension TopRatedMoviesViewController: TopRatedMoviesViewProtocol {
    
    func startLoading() {
        refreshControl.beginRefreshing()
    }
    
    func stopLoading() {
        refreshControl.endRefreshing()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension TopRatedMoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopRatedMoviesCell.reuseIdentifier, for: indexPath) as! TopRatedMoviesCell
        
        let cellViewModel = presenter.cellForRowAt(indexPath: indexPath) { image in
            cell.updateImage(image)
        }
        cell.configure(with: cellViewModel)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TopRatedMoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let movie = presenter.filteredMovies[indexPath.row]
        guard let viewController = onSelectMovie?(movie) else { return }
        show(viewController, sender: self)
    }
}
