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
        lable.font = .systemFont(ofSize: 19, weight: .bold)
        lable.numberOfLines = 0
        
        return lable
    }()

    lazy var subtitelLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 16, weight: .medium)
        lable.tintColor = .lightGray
        lable.numberOfLines = 0
        return lable
    }()
    
    
    
    lazy var newsImage: UIImageView = {
        let imageView =  UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBlue
        imageView.layer.cornerRadius = 10
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
            m.top.equalTo(6)
//            m.right.equalTo(-50)
            m.left.equalTo(2)
            m.height.equalToSuperview().inset(3)
            m.width.equalToSuperview().inset(0)
        
        }
       
        subtitelLable.snp.makeConstraints { m in
            m.top.equalTo(titelLable).inset(70)
            m.left.equalTo(2)
            m.right.equalTo(-2)
        }

        newsImage.snp.makeConstraints { m in
            
//            m.left.equalTo(titelLable).inset(290)
//            m.left.greaterThanOrEqualTo(titelLable).inset(290)
//            m.right.equalToSuperview().offset(-2)
//            m.centerX.equalTo(contentView).inset(12)
            m.centerX.equalTo(contentView).inset(-3)
            m.top.equalToSuperview().inset(5)
            m.bottom.equalTo(-5)
//            m.bottom.equalToSuperview().offset(-5)
//            m.width.equalToSuperview().inset(120)
//            m.height.equalToSuperview().inset(2)
            m.width.equalTo(140)
            m.height.equalTo(10)
        }

//        titelLable.frame = CGRect(x: 1, y: 0,
//                                  width: contentView.frame.size.width - 120,
//                                  height: contentView.frame.size.height/2)
//
//        subtitelLable.frame = CGRect(x: 1, y: 70,
//                                     width: contentView.frame.size.width - 140,
//                                     height: contentView.frame.size.height/2)
//
//
//
//        newsImage.frame = CGRect(x: contentView.frame.size.width - 120,
//                                 y: 5,
//                                 width: 160,
//                                 height: contentView.frame.size.height - 10)
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
