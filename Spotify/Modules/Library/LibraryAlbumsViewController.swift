//
//  LibraryAlbumsViewController.swift
//  Spotify
//
//  Created by Alex on 6/13/21.
//

import UIKit

final class LibraryAlbumsViewController: UIViewController {

    // MARK: - Properties
    
    private var albums = [Album]()
    
    private var observer: NSObjectProtocol?
    
    // MARK: - UI
    
    private let noAlbumsView = ActionLabelView()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNoAlbumsView()
        setupTableView()
        fetchData()
        observer = NotificationCenter.default.addObserver(forName: .albumSavedNotification, object: nil, queue: .main, using: { [weak self] _ in
            self?.fetchData()
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noAlbumsView.frame = CGRect(x: (view.width-150)/2, y: (view.height-150)/2, width: 150, height: 150)
        tableView.frame = view.bounds
    }
    
    // MARK: - Setup
    
    private func setupNoAlbumsView() {
        view.addSubview(noAlbumsView)
        noAlbumsView.configure(
            with: ActionLabelViewViewModel(
                text: "You have not saved any albums yet.",
                actionTitle: "Browse"
            )
        )
        noAlbumsView.delegate = self
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func updateUI() {
        if albums.isEmpty {
            noAlbumsView.isHidden = false
            tableView.isHidden = true
        } else {
            noAlbumsView.isHidden  = true
            tableView.isHidden = false
            tableView.reloadData()
        }
    }
    
    // MARK: - Private Methods
    
    private func fetchData() {
        self.albums.removeAll()
        APICaller.shared.getCurrentUserAlbums { [weak self] result in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let albums):
                    strongSelf.albums = albums
                    strongSelf.updateUI()
                case .failure(let error):
                    strongSelf.showErrorMessage(error.localizedDescription)
                }
            }
        }
    }

}

// MARK: - Extension for TableView Methods

extension LibraryAlbumsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier, for: indexPath) as? SearchResultSubtitleTableViewCell else { return UITableViewCell() }
        let album = albums[indexPath.row]
        cell.configure(with: SearchResultSubtitleTableViewCellViewModel(title: album.name, subtitle: album.artists.first?.name ?? "-", imageURL: URL(string: album.images.first?.url ?? "")))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        HapticsManager.shared.vibrateForSelection()
        let album = albums[indexPath.row]
        let albumViewController = AlbumViewController(album: album)
        albumViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(albumViewController, animated: true)
    }
    
}

// MARK: - Extension for ActionLabelViewDelegate

extension LibraryAlbumsViewController: ActionLabelViewDelegate {
    
    func ActionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        tabBarController?.selectedIndex = 0
    }
    
}
