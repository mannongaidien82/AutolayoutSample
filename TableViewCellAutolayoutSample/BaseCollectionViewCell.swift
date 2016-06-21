//
//  BaseCollectionViewCell.swift
//  TableViewCellAutolayoutSample
//
//  Created by 小川 幸大 on 2016/06/21.
//  Copyright © 2016年 Yukihiro Ogawa. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    
    class func reuseIdentifier() -> String {
        return className()
    }
    
    class func className() -> String {
        return NSStringFromClass(self).componentsSeparatedByString(".")[1]
    }
    
    class func nib() -> UINib {
        return UINib(nibName: className(), bundle: nil)
    }
    
    func calcCellSize(width: CGFloat) -> CGSize {
        var newFrame = frame
        newFrame.size.width = width
        frame = newFrame
        layoutIfNeeded()
        
        return containerView.frame.size
    }
}
