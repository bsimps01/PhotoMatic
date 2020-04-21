//
//  Photo.swift
//  L08_sandbox1
//
//  Created by Thomas Vandegriff on 2/13/19.
//  Copyright © 2019 Make School. All rights reserved.
//

import Foundation

class Photo {
    
    let title: String?
    let dateTaken: NSDate?
    let photoID: String?
    let remoteURL: URL?

    init(title: String?, dateTaken: NSDate?, photoID: String?, remoteURL: URL?)   {
        self.title = title
        self.dateTaken = dateTaken!
        self.photoID = photoID
        self.remoteURL = remoteURL
    }
}
