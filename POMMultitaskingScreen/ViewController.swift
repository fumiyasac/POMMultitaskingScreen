//
//  ViewController.swift
//  POMMultitaskingScreen
//
//  Created by Jeremiah Gage on 1/22/15.
//  Copyright (c) 2015 Jeremiah Gage. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    let POMAppCount = 20
    
    @IBOutlet var screenshotsCollectionView:UICollectionView!
    @IBOutlet var iconsCollectionView:UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let screenSize = UIScreen.main.bounds

        let screenshotsCollectionViewFlowLayout = screenshotsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        screenshotsCollectionViewFlowLayout.itemSize = CGSize(width: screenSize.width / 2.0, height: screenSize.height / 2.0)
        screenshotsCollectionViewFlowLayout.minimumInteritemSpacing = 0.0
        screenshotsCollectionViewFlowLayout.minimumLineSpacing = 20.0
        let screenshotsSectionInset = screenSize.width / 4.0
        screenshotsCollectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0.0, screenshotsSectionInset, 0.0, screenshotsSectionInset)

        let iconsCollectionViewFlowLayout = iconsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let iconHeight = iconsCollectionView.frame.height - 20.0
        iconsCollectionViewFlowLayout.itemSize = CGSize(width: iconHeight, height: iconHeight)
        iconsCollectionViewFlowLayout.minimumInteritemSpacing = 0.0
        iconsCollectionViewFlowLayout.minimumLineSpacing = 50.0
        let iconsSectionInset = screenshotsSectionInset + (screenshotsCollectionViewFlowLayout.itemSize.width - iconsCollectionViewFlowLayout.itemSize.width) / 2.0
        iconsCollectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0.0, iconsSectionInset, 0.0, iconsSectionInset)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return POMAppCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell
        
        if (collectionView == screenshotsCollectionView) {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenshotCell", for: indexPath) 
        }
        else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconCell", for: indexPath) 
            cell.layer.cornerRadius = 20.0
            cell.layer.masksToBounds = true
        }
        
        let hue = CGFloat(indexPath.item) / CGFloat(POMAppCount)
        cell.backgroundColor = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let screenshotsCollectionViewFlowLayout = screenshotsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let iconsCollectionViewFlowLayout = iconsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let screenshotsDistanceBetweenItemsCenter = screenshotsCollectionViewFlowLayout.minimumLineSpacing + screenshotsCollectionViewFlowLayout.itemSize.width
        let iconsDistanceBetweenItemsCenter = iconsCollectionViewFlowLayout.minimumLineSpacing + iconsCollectionViewFlowLayout.itemSize.width
        let offsetFactor = screenshotsDistanceBetweenItemsCenter / iconsDistanceBetweenItemsCenter

        if (scrollView == screenshotsCollectionView) {
            let xOffset = scrollView.contentOffset.x - scrollView.frame.origin.x
            iconsCollectionView.contentOffset.x = xOffset / offsetFactor
        }
        else if (scrollView == iconsCollectionView) {
            let xOffset = scrollView.contentOffset.x - scrollView.frame.origin.x
            screenshotsCollectionView.contentOffset.x = xOffset * offsetFactor
        }
    }
}

