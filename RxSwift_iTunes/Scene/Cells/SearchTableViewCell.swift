//
//  SearchTableViewCell.swift
//  RxSwift_iTunes
//
//  Created by 박소진 on 2023/11/06.
//

import UIKit

final class SearchTableViewCell: BaseTableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    let appNameView = AppNameView()
    
    let labelStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 15
        return stackView
    }()
    
    let rateStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }()
    
    let rateImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let rateLabel = {
        let label = UILabel()
        return label
    }()
    
    let sellerNameLabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    let genreLabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    let screenStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        return stackView
    }()
    
    let screenshotImageview1 = UIImageView()
    let screenshotImageview2 = UIImageView()
    let screenshotImageview3 = UIImageView()
    
    func configureCell(element: AppInfo) {
        
        self.selectionStyle = .none
        
        appNameView.appNameLabel.text = element.trackName
        
        let url = URL(string: element.artworkUrl512)
        appNameView.appIconImageView.kf.setImage(with: url)
        
        let screenshotUrls = element.screenshotUrls
        let test = [screenshotImageview1, screenshotImageview2, screenshotImageview3]
        
        for (index, value) in test.enumerated() {
            if let url = URL(string: screenshotUrls[index]) {
                value.kf.setImage(with: url)
            }
        }
        
        rateLabel.text = String(format: "%.1f", element.averageUserRating)
        sellerNameLabel.text = element.sellerName
        genreLabel.text = element.genres[0]
        
    }
    
    override func configure() {
        [appNameView.appNameLabel, appNameView.appIconImageView, appNameView.downloadButton, labelStackView, screenStackView].forEach { contentView.addSubview($0) }
        
        [rateStackView, sellerNameLabel, genreLabel].forEach { labelStackView.addArrangedSubview($0) }
        
        [rateImageView, rateLabel].forEach { rateStackView.addArrangedSubview($0) }
        
        [screenshotImageview1, screenshotImageview2, screenshotImageview3].forEach {
            screenStackView.addArrangedSubview($0)
            $0.contentMode = .scaleAspectFit
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.systemGray5.cgColor
            $0.clipsToBounds = true
        }
        
        [rateLabel, sellerNameLabel, genreLabel].forEach {
            $0.font = .systemFont(ofSize: 14, weight: .bold)
            $0.textColor = .gray
        }
        
        rateStackView.setContentHuggingPriority(.init(250), for: .horizontal)
        rateStackView.setContentCompressionResistancePriority(.init(751), for: .horizontal)
        sellerNameLabel.setContentHuggingPriority(.init(250), for: .horizontal)
        sellerNameLabel.setContentCompressionResistancePriority(.init(750), for: .horizontal)
        genreLabel.setContentHuggingPriority(.init(251), for: .horizontal)
        genreLabel.setContentCompressionResistancePriority(.init(751), for: .horizontal)
        
    }
    
    override func setConstraints() {
        
        appNameView.appIconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(20)
            $0.size.equalTo(60)
        }
        
        appNameView.appNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(appNameView.appIconImageView)
            $0.leading.equalTo(appNameView.appIconImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(appNameView.downloadButton.snp.leading).offset(-10)
        }
        
        appNameView.downloadButton.snp.makeConstraints {
            $0.centerY.equalTo(appNameView.appIconImageView)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(32)
            $0.width.equalTo(72)
        }
        
        labelStackView.snp.makeConstraints {
            $0.top.equalTo(appNameView.appIconImageView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(23)
            $0.height.equalTo(23)
        }
        
        rateImageView.snp.makeConstraints {
            $0.width.equalTo(labelStackView.snp.height)
        }
        
        screenStackView.snp.makeConstraints {
            $0.top.equalTo(labelStackView.snp.bottom).offset(8)
            $0.height.equalTo(appNameView.appIconImageView.snp.height).multipliedBy(3.2)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
    }
    
}
