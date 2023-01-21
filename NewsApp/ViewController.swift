//
//  ViewController.swift
//  NewsApp
//
//  Created by FIRDOUS UR RASOOL on 01/07/22.
//

import UIKit
import SafariServices
//TableView
//Custom cell
    //Api caller

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    private let tableView:UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return table
    }()
    private var articles = [Articles]()
    private var viewModels = [NewstableViewModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        Apicaller.getTopStories { [weak self]result in
            switch result{
            case.success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewstableViewModel(title: $0.title, subTitle: $0.description ?? "No description", imageUrl: URL(string: $0.urlToImage ?? "")
                    )
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case.failure(let error):
                print(error)
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else{
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        guard let url = URL(string: article.url ?? "") else{return}
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

}

