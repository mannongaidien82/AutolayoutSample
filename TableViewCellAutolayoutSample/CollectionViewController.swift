//
//  CollectionViewController.swift
//  TableViewCellAutolayoutSample
//
//  Created by 小川 幸大 on 2016/06/21.
//  Copyright © 2016年 Yukihiro Ogawa. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let kDataCount = 100
    private let kColumnCount = 1
    private let kMargin: CGFloat = 5
    
    var cellSizeCache: CGSize?
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.registerNib(BaseCollectionViewCell.nib(), forCellWithReuseIdentifier: BaseCollectionViewCell.reuseIdentifier())
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kDataCount * kColumnCount
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(BaseCollectionViewCell.reuseIdentifier(), forIndexPath: indexPath)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // ???: リロードのたびにインスタンス化してしまうのでキャッシュしてる
        guard let _cellSizeCache = cellSizeCache else {
            guard let cell = BaseCollectionViewCell.nib().instantiateWithOwner(self, options: nil).first as? BaseCollectionViewCell else {
                return CGSizeZero
            }
            cellSizeCache = cell.calcCellSize(cellWidth())
            return cellSizeCache!
        }

        
        return _cellSizeCache
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: kMargin, left: kMargin, bottom: kMargin, right: kMargin)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return kMargin
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return kMargin
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSizeZero
    }
    
    private func cellWidth() -> CGFloat {
        let marginSum = kMargin * CGFloat(kColumnCount + 1)
        
        return floor((UIScreen.mainScreen().bounds.width  - marginSum) / CGFloat(kColumnCount))
    }
}