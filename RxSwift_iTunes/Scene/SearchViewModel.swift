//
//  SearchViewModel.swift
//  RxSwift_iTunes
//
//  Created by 박소진 on 2023/11/06.
//

import Foundation
import RxSwift

final class SearchViewModel {
    
    let data: [AppInfo] = []
    
    lazy var items = BehaviorSubject(value: data)
    
    let disposeBag = DisposeBag()
    
    func callRequest(query: String) {
        let request = APIManager.shared.fetchData(query: query)
            .asDriver(onErrorJustReturn: SearchAppModel(resultCount: 0, results: []))
        
        request
            .drive(with: self) { owner, data in
                owner.items.onNext(data.results)
            }
            .disposed(by: disposeBag)
        
    }
}
