//
//  ViewController.swift
//  BestAppTest
//
//  Created by Карим Садыков on 29.11.2022.
//

import UIKit

class MainScreenViewController: UIViewController {

    var searchController = UISearchController()
    private var pageOffset = 0
    var photo = [Item]()
    private lazy var contentView = MainScreenView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        configureSearchController()
        configureCollectionViews()
        APICaller.shared.getPhoto(search: "random", num: 20) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.photo = data
                    self.contentView.photoCollectionView.reloadData()
                }
         
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    override func loadView() {
        view = contentView
    }
    
    private func configureCollectionViews() {
        contentView.photoCollectionView.delegate = self
        contentView.photoCollectionView.dataSource = self
        
        contentView.photoCollectionView.register(
            PhotoCell.self,
            forCellWithReuseIdentifier: PhotoCell.identifier
        )
    }
    
    func configureSearchController() {
        searchController.searchBar.placeholder = TextContent.Titles.SearchControllerPlaceHolder
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchController.searchBar.delegate = self
    }
    
    func configureNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.title = TextContent.Titles.NavigationTitle
    }

}

extension MainScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//            guard indexPath.row == pageOffset,
//                  pageOffset <= gifPaginationTotalCount
//            else { return }
            
//            gifOffset += 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let viewController = DetailViewController()
//        viewController.item = item
//
//        self.present(viewController, animated: true)
    }
}

extension MainScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCell.identifier,
            for: indexPath
        ) as? PhotoCell else { return UICollectionViewCell() }
        cell.fill(with: photo[indexPath.row].media.m)
        return cell
    }
    
    
}

extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2-15, height: self.view.frame.height/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
    }
}

extension MainScreenViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        guard let searchText = searchBar.text else { return }
//        Task {
//            try await self.viewModel?.fetch(for: searchText)
//        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        self.viewModel?.cancel()
    }
}
