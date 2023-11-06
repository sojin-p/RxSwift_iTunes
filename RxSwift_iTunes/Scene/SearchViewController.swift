//
//  ViewController.swift
//  RxSwift_iTunes
//
//  Created by 박소진 on 2023/11/06.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

final class SearchViewController: UIViewController {
    
    private let tableView: UITableView = {
       let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .white
        view.rowHeight = 80
        view.separatorStyle = .none
       return view
     }()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let data: [AppInfo] = []
    
    lazy var items = BehaviorSubject(value: data)
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configure()
        bind()
        setSearchController()
    }
    
    private func bind() {
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                
                cell.appNameLabel.text = element.trackName
                
                let url = URL(string: element.artworkUrl512)
                cell.appIconImageView.kf.setImage(with: url)
                
            }
            .disposed(by: disposeBag)
        
        searchController.searchBar.rx.searchButtonClicked
            .withLatestFrom(searchController.searchBar.rx.text.orEmpty, resultSelector: { _, text in
                return text
            })
            .subscribe(with: self) { owner, text in
                owner.callRequest(query: text)
            }
            .disposed(by: disposeBag)
        
    }
    
    private func callRequest(query: String) {
        let request = APIManager.shared.fetchData(query: query)
            .asDriver(onErrorJustReturn: SearchAppModel(resultCount: 0, results: []))
        
        request
            .drive(with: self) { owner, data in
                owner.items.onNext(data.results)
            }
            .disposed(by: disposeBag)
        
    }

}

extension SearchViewController {
    
    private func setSearchController() {
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
        navigationItem.searchController = searchController
        navigationItem.title = "검색"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

    }
    
}

