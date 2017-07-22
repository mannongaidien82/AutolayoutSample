//
//  CollectionViewController.swift
//  TableViewCellAutolayoutSample
//
//  Created by 小川 幸大 on 2016/06/21.
//  Copyright © 2016年 Yukihiro Ogawa. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    fileprivate let kDataCount = 100
    fileprivate let kColumnCount = 1
    fileprivate let kMargin: CGFloat = 5
    
    var cellSizeCache: CGSize?
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(BaseCollectionViewCell.nib(), forCellWithReuseIdentifier: BaseCollectionViewCell.reuseIdentifier())
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kDataCount * kColumnCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseCollectionViewCell.reuseIdentifier(), for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        // ???: リロードのたびにインスタンス化してしまうのでキャッシュしてる
        guard let _cellSizeCache = cellSizeCache else {
            guard let cell = BaseCollectionViewCell.nib().instantiate(withOwner: self, options: nil).first as? BaseCollectionViewCell else {
                return CGSize.zero
            }
            cellSizeCache = cell.calcCellSize(cellWidth())
            return cellSizeCache!
        }

        
        return _cellSizeCache
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: kMargin, left: kMargin, bottom: kMargin, right: kMargin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return kMargin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return kMargin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    fileprivate func cellWidth() -> CGFloat {
        let marginSum = kMargin * CGFloat(kColumnCount + 1)
        
        return floor((UIScreen.main.bounds.width  - marginSum) / CGFloat(kColumnCount))
    }
}
