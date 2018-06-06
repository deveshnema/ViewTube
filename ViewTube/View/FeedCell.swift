//
//  FeedCell.swift
//  ViewTube
//
//  Created by Devesh Nema on 6/2/18.
//  Copyright © 2018 Devesh Nema. All rights reserved.
//

import UIKit

fileprivate let cellid = "cellid"

class FeedCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    var videos: [Video]?

    func fetchVideos(with urlString: String) {
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            guard let data = data else { return }
            if let error = error {
                print(error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                self.videos = try decoder.decode([Video].self, from: data)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch let err {
                print(err)
            }
        }) .resume()
    }

    override func setupViews() {
        super.setupViews()
        fetchVideos(with: "https://s3-us-west-2.amazonaws.com/youtubeassets/home_num_likes.json")
        
        addSubview(collectionView)
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellid)
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
         func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return videos?.count ?? 0
        }
    
         func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! VideoCell
            cell.video = videos?[indexPath.item]
            return cell
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let height = (frame.width - 16 - 16) * 9/16
            return CGSize(width: frame.width, height: height + 16 + 4 + 44 + 16 + 1)
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vl = VideoLauncher()
        vl.showVideoPlayer()
    }
    
}
