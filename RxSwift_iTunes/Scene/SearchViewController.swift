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

final class SearchViewController: UIViewController {
    
    private let tableView: UITableView = {
       let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .white
        view.rowHeight = 80
        view.separatorStyle = .none
       return view
     }()
    
    let items = BehaviorSubject(value: ["테스트", "구름모드", "투두", "다이어리", "gjgjgk"])
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        bind()
    }
    
    func bind() {
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                cell.appNameLabel.text = element
                cell.appIconImageView.backgroundColor = .systemYellow
            }
            .disposed(by: disposeBag)
        
    }

}

extension SearchViewController {
    
    private func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

    }
    
}

