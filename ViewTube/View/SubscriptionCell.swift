//
//  SubscriptionCell.swift
//  ViewTube
//
//  Created by Devesh Nema on 6/4/18.
//  Copyright © 2018 Devesh Nema. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    override func setupViews() {
        super.setupViews()
        fetchVideos(with: "https://s3-us-west-2.amazonaws.com/youtubeassets/subscriptions.json")
    }
}

