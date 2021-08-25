//
//  ViewController.swift
//  NewsApp
//
//  Created by Anton Tuzov on 14.05.2021.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
   

    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier:  NewsTableViewCell.identifier)
        return table
    }()
    
    private let searchVC = UISearchController(searchResultsController: nil)
    
    
    
    
    private var articles = [Article]()
    private var viewModels = [NewsTableViewCellViewModels]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        navigationItem.largeTitleDisplayMode = .always
        title = "News for today"
        createSearchBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
                    image: UIImage(systemName: "gear"),
                    style: .done,
                    target: self,
                    action: #selector(didTapSettings)
                )
//        tableView.snp.makeConstraints { m in
//            m.edges.equalToSuperview()
//
//        }
//        tableView.estimatedRowHeight = 150
//        tableView.rowHeight = 150
        
        tableView.delegate = self
        tableView.dataSource = self
      
    }
    
    
    private func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    @objc func didTapSettings() {
               let vc = SettingsViewController()
               vc.title = "Settings"
               vc.navigationItem.largeTitleDisplayMode = .never
               navigationController?.pushViewController(vc, animated: true)
           }
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        APIBase.shared.getNews { [weak self] result  in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModels(titel: $0.title ?? "",
                                                subtitel: $0.description ?? "no description",
                                                imageURL: URL(string: $0.urlToImage ?? "" ))
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
        
        
 
    }
    
    
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(
            withIdentifier:  NewsTableViewCell.identifier,
            for: indexPath) as?  NewsTableViewCell else {
                fatalError("😥")
            }
        cell.configure(with: viewModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        guard let url = URL(string: article.url ?? "") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        APIBase.shared.searchNews(with: text) { [weak self] result  in
            switch result {
            case .success(let articles):
                self?.articles = articles!
                self?.viewModels = articles!.compactMap({
                    NewsTableViewCellViewModels(titel: $0.title ?? "",
                                                subtitel: $0.description ?? "no description",
                                                imageURL: URL(string: $0.urlToImage ?? "" ))
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

