//
//  DownloadsViewController.swift
//  Netflix Clone
//
//  Created by Noah Pope on 11/29/22.
//

import UIKit

class DownloadsViewController: UIViewController {
    
    let downloadedTable             = UITableView()
    private var titles: [TitleItem] = []
    
//    private let downloadedTable: UITableView = {
//        //we're only using the URL here so use closure based initialization
//        let table = UITableView()
//        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
//        return table
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureTableView()
        fetchLocalStorageForDownload()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue: nil) { _ in
            self.fetchLocalStorageForDownload() //contains logic to reload the data/refresh view w updates
        }
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        downloadedTable.frame = view.bounds
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.downloadedTable.reloadData()
    }
    
    
    func configureNavigation() {
        view.backgroundColor = .systemBackground
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    
    func configureTableView() {
        view.addSubview(downloadedTable)
        downloadedTable.frame = view.bounds
        downloadedTable.delegate = self
        downloadedTable.dataSource = self
        downloadedTable.removeExcessCells()
        
        downloadedTable.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
    }
    
    
    private func fetchLocalStorageForDownload() {
        DataPersistenceManager.shared.fetchingTitlesFromDataBase { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                
                DispatchQueue.main.async {
                    self?.downloadedTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        
        let title       = titles[indexPath.row]
        cell.configure(with: TitleViewModel(titleName: (title.original_title ?? title.original_name) ?? "Unknown", posterURL: title.poster_path ?? ""))
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            
            DataPersistenceManager.shared.deleteTitlewith(model: titles[indexPath.row]) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success():
                    print("deleted title from database")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self.titles.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break;
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_title else { return }
        
        APICaller.shared.getMovie(with: titleName) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let videoElement):
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    let configureModel = TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? "")
                    
                    vc.configure(with: configureModel)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

