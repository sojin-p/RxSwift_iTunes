//
//  AppNameTabelViewCell.swift
//  RxSwift_iTunes
//
//  Created by 박소진 on 2023/11/08.
//

import UIKit

final class AppNameTabelViewCell: BaseTableViewCell {
    
    static let identifier = "AppNameTabelViewCell"
    
    let appNameView = AppNameView()
    
    let containerView = {
        let view = UIView()
        return view
    }()
    
    override func configure() {
        appNameView.appNameLabel.numberOfLines = 2
        
        [appNameView.appIconImageView, containerView].forEach { contentView.addSubview($0) }
        
        [appNameView.appNameLabel, appNameView.downloadButton].forEach { containerView.addSubview($0) }
    }
    
    override func setConstraints() {
        
        appNameView.appIconImageView.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.equalTo(appNameView.appIconImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(appNameView.appIconImageView)
        }
        
        appNameView.appNameLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        appNameView.downloadButton.snp.makeConstraints { make in
            make.top.equalTo(appNameView.appNameLabel.snp.bottom).offset(4)
            make.leading.bottom.equalToSuperview()
            make.width.equalTo(72)
            make.height.equalTo(32)
        }
        
    }
}
