//
//  SearchResultsViewController.swift
//  Netflix Clone
//
//  Created by Noah Pope on 1/6/23.
//

//STUDYING RELATIONSHIP BTWN SEARCHVC AND SEARCHRESULTSVC
import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func SearchResultsViewControllerDidTapItem(_ viewModel: TitlePreviewViewModel)
}

class SearchResultsViewController: UIViewController {
    
    public var titles: [Title] = [Title]()
    
    public weak var delegate: SearchResultsViewControllerDelegate?
    
    public let searchResultsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0 
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen
        view.addSubview(searchResultsCollectionView)
        
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }

}

// MARK: DELEGATE AND DATASOURCE METHODS
extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let title = titles[indexPath.row]
        cell.configure(with: title.poster_path ?? "") 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else {return}
       
        
        APICaller.shared.getMovie(with: titleName) { [weak self] result in
            switch result {
                
            case .success(let videoElement):
                let configureModel = TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? "")
                self?.delegate?.SearchResultsViewControllerDidTapItem(configureModel)

            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        
    }
    
}
