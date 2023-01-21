//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by FIRDOUS UR RASOOL on 01/07/22.
//

import UIKit
class NewstableViewModel{
    let title:String
    let subTitle:String
    let imageUrl:URL?
    var imageData:Data? = nil
    
    init (title:String,subTitle:String,imageUrl:URL?){
        self.title = title
        self.subTitle = subTitle
        self.imageUrl = imageUrl
        
    }
}
class NewsTableViewCell: UITableViewCell {

   static let identifier = "NewsTableViewCell"
    private let newstitleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 22)
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    private let subtitleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .light)
        
        return label
    }()
    private let newsImageView:UIImageView = {
        let imageview = UIImageView()
        imageview.backgroundColor = .secondarySystemBackground
        imageview.layer.cornerRadius = 6
        imageview.layer.masksToBounds = true
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleToFill
        return imageview
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newstitleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(newsImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        newstitleLabel.frame = CGRect(x: 5, y: 0, width: contentView.frame.width - 160, height: contentView.frame.height/2)
        subtitleLabel.frame = CGRect(x: 10, y: 70, width: contentView.frame.width - 170, height: contentView.frame.height/2)
        newsImageView.frame = CGRect(x: contentView.frame.size.width - 140, y: 5, width: 160, height: contentView.frame.size.height - 10)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newstitleLabel.text = nil
        subtitleLabel.text = nil
        newsImageView.image = nil
    }
    
    func configure(with viewModel:NewstableViewModel){
        newstitleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subTitle
        
        //Image
        if let data = viewModel.imageData{
            newsImageView.image = UIImage(data: data)
            
        }else if let url = viewModel.imageUrl{
            //fetch the image
            URLSession.shared.dataTask(with: url) { [weak self]data, response, error in
                guard let data = data , error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
