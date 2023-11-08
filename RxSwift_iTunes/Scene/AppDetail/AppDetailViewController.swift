//
//  AppDetailViewController.swift
//  RxSwift_iTunes
//
//  Created by 박소진 on 2023/11/06.
//

import UIKit
import RxSwift
import RxCocoa

final class AppDetailViewController: UIViewController {
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(AppNameTabelViewCell.self, forCellReuseIdentifier: AppNameTabelViewCell.identifier)
        view.backgroundColor = .white
        view.rowHeight = 100
        view.separatorStyle = .none
        return view
    }()
    
    let items = BehaviorRelay(value: ["1","2","3"])
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        bind()
    }
    
    func bind() {
        
        items
            .asDriver()
            .drive(tableView.rx.items(cellIdentifier: AppNameTabelViewCell.identifier, cellType: AppNameTabelViewCell.self)) { (row, element, cell) in
                cell.appNameView.appNameLabel.text = "구름모드구름모드구름모드구름모드구름모드구름모드구름모드구름모드구름모드"
                cell.appNameView.appIconImageView.backgroundColor = .brown
                cell.containerView.backgroundColor = .cyan
            }
            .disposed(by: disposeBag)
        
    }
    
}

extension AppDetailViewController {
    
    private func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

    }
    
}
