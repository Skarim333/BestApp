//
//  ViewController.swift
//  BestAppTest
//
//  Created by Карим Садыков on 29.11.2022.
//

import UIKit

class MainScreenViewController: UIViewController {

    var searchController = UISearchController()
    var photo = [Item]()
    private lazy var contentView = MainScreenView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAlertFilter()
        configureNavigationController()
        configureSearchController()
        configureCollectionViews()
        APICaller.shared.getPhoto() { [weak self] result in
            guard let self = self else { return }
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
    
    func showAlertFilter() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape.2"), style: .done, target: self, action: #selector(tapButton))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func tapButton() {
        let actionSheet = UIAlertController(title: "Sort Order",
                                            message: nil,
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Sort title name", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.photo = self.photo.sorted(by: {$0.title < $1.title})
                self.contentView.photoCollectionView.reloadData()
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Sort creation Date", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.photo = self.photo.sorted(by: {$0.date_taken < $1.date_taken})
                self.contentView.photoCollectionView.reloadData()
            }
        }))
        present(actionSheet, animated: true)
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        viewController.url = self.photo[indexPath.item].media.m
        self.present(viewController, animated: true)
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
        cell.fill(with: photo[indexPath.row])
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
        APICaller.shared.getSearchPhoto(search: searchBar.text ?? "random") { [weak self] result in
            guard let self = self else { return }
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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        self.viewModel?.cancel()
    }
}
