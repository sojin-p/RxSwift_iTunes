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
        view.estimatedRowHeight = 250
        view.rowHeight = UITableView.automaticDimension
        view.separatorStyle = .none
       return view
     }()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let viewModel = SearchViewModel()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configure()
        bind()
        setSearchController()
    }
    
    private func bind() {
        
        let input = SearchViewModel.Input(
            searchButtonClicked:  searchController.searchBar.rx.searchButtonClicked,
            searchText: searchController.searchBar.rx.text)
        
        let output = viewModel.transform(input: input)
        
        output.items
            .asDriver()
            .drive(tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                
                cell.configureCell(element: element)
                
            }
            .disposed(by: disposeBag)
        
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(AppInfo.self))
            .subscribe { [weak self] index, data in
                print("====",data)
                let vc = AppDetailViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
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

