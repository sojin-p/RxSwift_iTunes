//
//  SearchViewModel.swift
//  RxSwift_iTunes
//
//  Created by 박소진 on 2023/11/06.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {
    
    struct Input {
        let searchButtonClicked: ControlEvent<Void>
        let searchText: ControlProperty<String?>
    }
    
    struct Output {
        let items: BehaviorRelay<[AppInfo]>
    }
    
    var data: [AppInfo] = []
    
    let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let searchList = BehaviorRelay(value: data)
        
        input.searchButtonClicked
            .withLatestFrom(input.searchText.orEmpty, resultSelector: { _, text in
                return text
            })
            .flatMap { APIManager.shared.fetchData(query: $0) }
            .subscribe(with: self) { owner, data in
                let data = data.results
                searchList.accept(data)
            }
            .disposed(by: disposeBag)
        
        return Output(items: searchList)
        
    }
}
