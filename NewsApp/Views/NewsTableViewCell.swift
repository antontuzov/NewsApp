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
        lable.numberOfLines = 2
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()

    lazy var subtitelLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 16, weight: .medium)
        lable.tintColor = .lightGray
        lable.numberOfLines = 3
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    

    lazy var newsImage: UIImageView = {
        let imageView =  UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBlue
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
      

        newsImage.snp.makeConstraints { m in

            m.top.equalTo(5)
            m.left.equalToSuperview().inset(2)
            m.bottom.equalToSuperview().inset(-2)
            m.height.equalToSuperview().inset(160)
            m.width.equalToSuperview().inset(140)
        
        
        }
        titelLable.snp.makeConstraints { m in
            m.left.equalTo(120)
            m.right.equalTo(-2)
            m.top.equalTo(2)

        
        }
       
        subtitelLable.snp.makeConstraints { m in
            m.left.equalTo(120)
            m.right.equalTo(-2)
            m.top.equalToSuperview().inset(70)
            
        }
        
        
        
        
        
        
        
//
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
//        newsImage.frame = CGRect(x: contentView.frame.size.width - 110,
//                                 y: 5,
//                                 width: 160,
//                                 height: contentView.frame.size.height - 10)
        
        
        
        
//        NSLayoutConstraint.activate([
//            titelLable.topAnchor.constraint(equalTo: topAnchor, constant: 0),
//            titelLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1),
//            titelLable.widthAnchor.constraint(equalToConstant: contentView.frame.size.width - 120),
//            titelLable.heightAnchor.constraint(equalToConstant: contentView.frame.size.height/2)
//
//
//        ])
//
//
//        NSLayoutConstraint.activate([
//            subtitelLable.topAnchor.constraint(equalTo: topAnchor, constant: 70),
//            subtitelLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1),
//            subtitelLable.widthAnchor.constraint(equalTo: widthAnchor, constant: contentView.frame.size.width - 140),
//            subtitelLable.heightAnchor.constraint(equalToConstant: contentView.frame.size.height/2)
//
//
//        ])
//
//
//        NSLayoutConstraint.activate([
//            newsImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: contentView.frame.size.width - 110),
//            newsImage.widthAnchor.constraint(equalToConstant: 160),
//            newsImage.heightAnchor.constraint(equalToConstant: contentView.frame.size.height - 10),
//            newsImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
//            newsImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
////            newsImage.leadingAnchor.constraint(equalTo: subtitelLable.trailingAnchor, constant: 2)
//
//        ])

        
        
        
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





    }
