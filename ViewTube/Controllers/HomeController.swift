//
//  ViewController.swift
//  ViewTube
//
//  Created by Devesh Nema on 5/30/18.
//  Copyright © 2018 Devesh Nema. All rights reserved.
//

import UIKit

fileprivate let feedcellid = "feedcellid"
fileprivate let subscriptionCellId = "subscriptionCellId"


class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32 , height: view.frame.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        setupCollectionView()
        setupMenuBar()
        setNavBarButtons()
    }

    func setupCollectionView() {
        collectionView?.backgroundColor = UIColor.white
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        collectionView?.isPagingEnabled = true
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: feedcellid)
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)

        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    let menuBar : MenuBar = {
        let mb = MenuBar()
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    
    func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        let redView = UIView()
        redView.backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        redView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(redView)
        redView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        redView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        redView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(menuBar)
        menuBar.homeController = self
        menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    func setNavBarButtons() {
        let searchButton = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(handleSearch))
        let moreButton = UIBarButtonItem(image: UIImage(named: "more")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButton, searchButton]
    }
    
    @objc func handleSearch() {
        
    }
    
    @objc func handleMore() {
        
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: true)
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = menuBar.images[menuIndex].capitalizingFirstLetter()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier: String
        if indexPath.item == 0 {
            identifier = feedcellid
        } else if indexPath.item == 2 {
            identifier = subscriptionCellId
        } else {
            //default just use feedcellid
            identifier = feedcellid
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        //let colors : [UIColor] = [#colorLiteral(red: 0.482165277, green: 0.1738786995, blue: 0.8384277225, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)]
        //cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x/5
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.left)
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = menuBar.images[Int(index)].capitalizingFirstLetter()
        }
    }
}

