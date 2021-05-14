//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Anton Tuzov on 14.05.2021.
//

import UIKit
import SnapKit

class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell"
    
    
    
    
    lazy var titelLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 20, weight: .bold)
        lable.numberOfLines = 0
        return lable
    }()

    lazy var subtitelLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 18, weight: .regular)
        lable.tintColor = .gray
        lable.numberOfLines = 0
        return lable
    }()
    
    
    
    lazy var newsImage: UIImageView = {
        let imageView =  UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBlue
        return imageView
    }()
    
    
    
//
//    lazy var just: UIView = {
//        let lable = UIView()
//        lable.backgroundColor = .green
//        lable.clipsToBounds = true
//        return lable
//    }()
    
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    
        
        contentView.addSubview(titelLable)
        contentView.addSubview(subtitelLable)
        contentView.addSubview(newsImage)
        
            
        
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titelLable.snp.makeConstraints { m in
            m.top.equalToSuperview().inset(5)
            m.left.equalToSuperview().inset(5)
        }
       
        subtitelLable.snp.makeConstraints { m in
            m.top.equalTo(titelLable).inset(100)
            m.left.equalToSuperview().inset(5)
        }

        newsImage.snp.makeConstraints { m in
            
            m.left.equalTo(titelLable).inset(290)
            m.right.equalTo(titelLable).inset(-5)
            m.top.equalToSuperview().inset(5)
            m.bottom.equalToSuperview().inset(5)
            m.width.equalToSuperview().inset(130)
            m.height.equalToSuperview().inset(-10)
        }

        
        
    
    }

      override func prepareForReuse() {
        super.prepareForReuse()
        titelLable.text = nil
        subtitelLable.text = nil
        newsImage.image = nil
       }
    
    func configure(with viewModels: NewsTableViewCellViewModels) {
        titelLable.text = viewModels.titel
        subtitelLable.text = viewModels.subtitel
        
        
        
        if let data = viewModels.imageData {
            newsImage.image = UIImage(data: data)
        }
        else if let url = viewModels.imageURL {
            
            URLSession.shared.dataTask(with: url) { [weak self ] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModels.imageData = data
                DispatchQueue.main.async {
                    self?.newsImage.image = UIImage(data: data)
                }
            }.resume()
            
            
            
        }
        
        
    
    
}



//view.addSubview(view1)
//view1.snp.makeConstraints { (m) in
//    m.width.equalTo(15)
//    m.height.equalTo(15)
//    m.top.equalToSuperview().inset(100)
//    m.left.equalToSuperview().inset(20)

    }
