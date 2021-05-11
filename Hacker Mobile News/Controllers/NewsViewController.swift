//
//  NewsViewController.swift
//  Hacker Mobile News
//
//  Created by Mario Elorza on 06-05-21.
//

import UIKit
import SafariServices

class NewsViewController: UITableViewController  {
    
    var stories: [Story] = []
    var networkManager: NetworkManager
    var persistenceManager: PersistenceManager
    var loadingView: UIView!
    
    init(networkManager: NetworkManager, persistenceManager: PersistenceManager) {
        self.networkManager = networkManager
        self.persistenceManager = persistenceManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Mobile News"
        configureTableView()
        fetchStories()
    }
    
    @objc func fetchStories() {
        let dispatchGroup = DispatchGroup()
        startLoading()
        networkManager.getMobileNews { [weak self] result in
            guard let self = self else { return }
            dispatchGroup.enter()
            switch result {
            case .success(let stories):
                stories.forEach { self.persistenceManager.saveStorie($0)}
            case .failure(let error):
                print("There was an error fetching the stories from service \(error)")
            }
            dispatchGroup.leave()
            dispatchGroup.notify(queue: .main) {
                self.stopLoading()
                self.loadStoriesFromStorage()
            }
        }
    }
    
    func loadStoriesFromStorage() {
        self.persistenceManager.loadStories { result in
            switch result {
            case .success(let stories):
                self.stories = stories
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("There was an error loading the stories from Core Data \(error)")
            }
        }
    }
    
    fileprivate func configureTableView() {
        tableView.rowHeight = 84
        tableView.backgroundColor = .systemBackground
        tableView.register(StoryViewCell.self, forCellReuseIdentifier: StoryViewCell.reuseID)
        tableView.tableFooterView = UIView(frame: .zero)
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(fetchStories), for: .valueChanged)
    }
    
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryViewCell.reuseID, for: indexPath) as! StoryViewCell
        cell.set(story: stories[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = stories[indexPath.row]
        guard let url = URL(string: story.url) else { return }
        presentSafariVC(with: url)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        tableView.beginUpdates()
        let story = self.stories[indexPath.row]
        persistenceManager.removeStory(story) {
            self.stories.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
        }
    }

}

extension NewsViewController {
    
    func startLoading() {
        loadingView = UIView(frame: tableView.bounds)
        tableView.backgroundView = loadingView
        loadingView.alpha = 0
        UIView.animate(withDuration: 0.25) { self.loadingView.alpha = 0.8 }
        let activityIndicator = UIActivityIndicatorView(style: .large)
        loadingView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor)
        ]);
        activityIndicator.startAnimating()
    }
    
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.tableView.backgroundView = nil
            self.loadingView = nil
            self.refreshControl?.endRefreshing()
        }
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
}
