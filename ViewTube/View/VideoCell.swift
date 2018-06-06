//
//  VideoCell.swift
//  ViewTube
//
//  Created by Devesh Nema on 5/30/18.
//  Copyright © 2018 Devesh Nema. All rights reserved.
//

import UIKit

class VideoCell : BaseCell {
    
    var video: Video? {
        didSet {
            if let title = video?.title {
                titleLabel.text = title
            }
            
            if let thumbnailImageUrl = video?.thumbnail_image_name {
                thumbnailImageView.loadImageUsingUrlString(thumbnailImageUrl)
            }
            
            if let profileImageUrl = video?.channel?.profile_image_name {
                profileImageView.loadImageUsingUrlString(profileImageUrl)
            }
            
            if let channelName = video?.channel?.name, let numberOfViews = video?.number_of_views {
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let viewsString = numberFormatter.string(from: NSNumber(value: numberOfViews))!
                let subtitleText = "\(channelName) • \(viewsString) • 2 years ago "
                subtitleTextView.text = subtitleText
            }
            
            //measure title text
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }
            
        }
    }
    
    let thumbnailImageView : CustomImageView = {
        let iv = CustomImageView()
        iv.image = UIImage(named: "taylor_thumbnail")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let profileImageView : CustomImageView = {
        let iv = CustomImageView()
        iv.image = UIImage(named: "taylor_profile")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 22
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let dividerLine : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.8, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Taylor Swift - Blank Space"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleTextView : UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.textColor = UIColor.lightGray
        tv.text = "TaylorSwiftVEVO · 2,296,114,694 views · Nov 10, 2014"
        tv.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    var titleLabelHeightConstraint: NSLayoutConstraint?

    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(dividerLine)
        addSubview(profileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true

        profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        profileImageView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true

        titleLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor).isActive = true
        titleLabelHeightConstraint = titleLabel.heightAnchor.constraint(equalToConstant: 20)
        titleLabelHeightConstraint?.isActive = true

        subtitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        subtitleTextView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8).isActive = true
        subtitleTextView.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor).isActive = true
        subtitleTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        dividerLine.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16).isActive = true
        dividerLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        dividerLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        dividerLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

    }
}
