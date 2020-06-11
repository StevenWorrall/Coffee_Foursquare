//
//  ResultCell.swift
//  Coffee_Finder
//
//  Created by Steven Worrall on 6/8/20.
//  Copyright © 2020 Steven Worrall. All rights reserved.
//

import UIKit
import SnapKit

class ResultCell: UITableViewCell {
    private let spacingConstant:CGFloat = 10
    private let avatarSize: CGFloat = 50
    private lazy var photoHeight = UIScreen.main.bounds.width
    
    public var data: Venue? {
        didSet {
            if let unwrappedVenueURL = data?.bestPhoto?.urlString {
                self.venueImageView.loadImageUsingUrlString(unwrappedVenueURL)
            }
            
            if let groupCount = data?.tips?.groups?.count,
                let itemCount = data?.tips?.groups?[0].items?.count {
                if groupCount < 1 || itemCount < 1 {
                    return
                }
            }
            if let tip = data?.tips?.groups?[0].items?[0] {
                if let unwrappedAvatarURL = tip.user?.photo?.urlString {
                    self.avatarImageView.loadImageUsingUrlString(unwrappedAvatarURL)
                }
                
                let name = tip.user?.firstName ?? "Unknown"
                self.personNameLabel.text = name
                
                self.tipLabel.attributedText = self.createTipLabelText(name: name, text: tip.text ?? "")
                
                if let likes = tip.agreeCount {
                    self.likesLabel.text = "\(String(describing: likes)) Likes"
                } else {
                    self.likesLabel.text = "0 Likes"
                }
            }
            
            self.venueNameLabel.text = data?.name ?? "Name Unknown"
            self.addressLabel.text = data?.location?.address ?? "Address Unknown"
            
            if let rating = data?.rating {
                self.ratingLabel.text = "Rating: \(String(describing: rating))"
            } else {
                self.ratingLabel.text = "Rating Unknown"
            }
        }
    }
    private let venueImageView: CustomImageView = {
        let temp = CustomImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.contentMode = .scaleAspectFill
        temp.layer.masksToBounds = true
        return temp
    }()
    private lazy var avatarImageView: CustomImageView = {
        let temp = CustomImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.contentMode = .scaleAspectFill
        temp.layer.masksToBounds = true
        temp.layer.cornerRadius = self.avatarSize / 2
        return temp
    }()
    private let venueNameLabel: UILabel = {
        let temp = UILabel()
        temp.textColor = .black
        temp.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    private let personNameLabel: UILabel = {
        let temp = UILabel()
        temp.textColor = .black
        temp.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    private let tipLabel: UILabel = {
        let temp = UILabel()
        temp.textColor = .black
        temp.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.numberOfLines = 0
        temp.lineBreakMode = .byWordWrapping
        temp.sizeToFit()
        return temp
    }()
    private let likesLabel: UILabel = {
        let temp = UILabel()
        temp.textColor = .black
        temp.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    private let addressLabel: UILabel = {
        let temp = UILabel()
        temp.textColor = .darkGray
        temp.font = UIFont.systemFont(ofSize: 16, weight: .light)
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    private let ratingLabel: UILabel = {
        let temp = UILabel()
        temp.textColor = .darkGray
        temp.font = UIFont.systemFont(ofSize: 16, weight: .light)
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.contentView.addSubview(self.avatarImageView)
        self.avatarImageView.snp.makeConstraints { (make) in
            make.leading.top.equalToSuperview().offset(10)
            make.height.width.equalTo(self.avatarSize)
        }
        
        self.contentView.addSubview(self.personNameLabel)
        self.personNameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.avatarImageView.snp.trailing).offset(10)
            make.centerY.equalTo(self.avatarImageView.snp.centerY).offset(-5)
            make.trailing.equalToSuperview()
        }
        
        self.contentView.addSubview(self.venueNameLabel)
        self.venueNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.personNameLabel.snp.bottom)
            make.leading.equalTo(self.avatarImageView.snp.trailing).offset(10)
        }
        
        self.contentView.addSubview(self.addressLabel)
        self.addressLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.personNameLabel.snp.bottom)
            make.leading.equalTo(self.venueNameLabel.snp.trailing).offset(5)
        }
        
        self.contentView.addSubview(self.ratingLabel)
        self.ratingLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.personNameLabel.snp.bottom)
            make.leading.equalTo(self.addressLabel.snp.trailing).offset(5)
        }
        
        self.contentView.addSubview(self.venueImageView)
        self.venueImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.avatarImageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.photoHeight)
        }
        
        self.contentView.addSubview(self.likesLabel)
        self.likesLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.venueImageView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
        }
        
        self.contentView.addSubview(self.tipLabel)
        self.tipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.likesLabel.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    private func createTipLabelText(name: String, text: String) -> NSMutableAttributedString {
        let boldText = name + " "
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)

        let normalText = text
        let normalString = NSMutableAttributedString(string:normalText)

        attributedString.append(normalString)
        
        return attributedString
    }
    
    private func makeStringBold(str: String) -> NSMutableAttributedString {
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)]
        let attributedString = NSMutableAttributedString(string:str, attributes:attrs)
        
        return attributedString
    }
}
