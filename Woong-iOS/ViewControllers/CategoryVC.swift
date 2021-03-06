//
//  CategoryVC.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 2..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {
    var myAddress = ""
    let bigCellId = "BigCategoryCell"
    let smallCellId = "SmallCategoryCell"
    let bigCategory = ["과일", "곡물", "채소", "달걀/유제품"]
    var bigCategoryIndex = 0
    
    var categoryTextArr:[String] = []
    var categoryImageArr:[String] = []
    let vegetableArr = ["감자", "고구마", "고추", "나물","버섯", "열매 채소", "잎 채소", "뿌리 채소"]
    let vegetableImageArr = ["home-vegetable-potato", "home-vegetable-sweetpotato","home-vegetable-chili", "home-vegetable-greens", "home-vegetable-mushroom", "home-vegetable-fruit", "home-vegetable-leaf", "home-vegetable-root"]
    
    let fruitArr = ["바나나", "복숭아", "사과", "오렌지", "딸기"]
    let fruitImgaeArr = ["home-fruit-banana", "home-fruit-peach", "home-fruit-apple","home-fruit-orange", "home-fruit-strawberry"]
    
    let cerealArr = ["쌀", "오곡", "잡곡"]
    let cerealImageArr = ["home-cereal-rice", "home-cereal-ogok", "home-cereal-grain"]
    
    let eggArr = ["달걀", "우유"]
    let eggImageArr = ["home-egg-egg", "home-egg-milk"]
    
    @IBOutlet var bigCategoryCollectionView: UICollectionView!
    @IBOutlet var bigCategoryView: UIView!
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    @IBOutlet var smallCategoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocation(location: myAddress)
        let shadowImage = UIImage()
        navigationController?.navigationBar.shadowImage = shadowImage
        setupCollectionView()
        setupHorizontalBar()
        setupNaviBar()
        setupCategory(categoryIndex: bigCategoryIndex)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .rgb(red: 82, green: 156, blue: 119)
        
    }
    
    private func setupNaviBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFEB", size: 17)!]
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    private func setupLocation(location: String){
        let testFrame : CGRect = CGRect(x: 0, y: 0, width: 180, height: 50)
        let buttonView: UIView = UIView(frame: testFrame)
        let locationbutton =  UIButton(type: .system) as UIButton
        locationbutton.frame = CGRect(x: 0, y: 0, width: 180, height: 50)

        
        locationbutton.tintColor = .white
        locationbutton.semanticContentAttribute = .forceRightToLeft
        locationbutton.setTitle("\(self.myAddress) ", for: .normal)
        locationbutton.setTitleColor(UIColor.white
            , for: .normal)
//        locationbutton.setImage(locationimage, for: .normal)
        locationbutton.titleLabel?.font = UIFont(name: "NanumSquareOTFEB", size: 17)
        locationbutton.isUserInteractionEnabled = false
        buttonView.addSubview(locationbutton)
        
        self.navigationItem.titleView = buttonView
    }
    
    private func setupCollectionView() {
        self.bigCategoryCollectionView.delegate = self
        self.bigCategoryCollectionView.dataSource = self
        self.smallCategoryCollectionView.delegate = self
        self.smallCategoryCollectionView.dataSource = self
        self.bigCategoryView.applyShadow(radius: 6, color: .black, offset: CGSize(width: 0, height: 3), opacity: 0.15)
        
    }
    
    private func setupHorizontalBar() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor.rgb(red: 82, green: 156, blue: 119)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        bigCategoryView.addSubview(horizontalBarView)
        
        //horizontalBarLeftAnchorConstraint = bigCategoryBar.leftAnchor.
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: bigCategoryView.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        
        horizontalBarView.bottomAnchor.constraint(equalTo: bigCategoryView.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: bigCategoryView.widthAnchor, multiplier: 1/4).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    func setupCategory(categoryIndex: Int) {
        horizontalBarLeftAnchorConstraint?.constant = CGFloat(categoryIndex) * (self.view.frame.width / 4)
        let selectedIndexPath = NSIndexPath(item: categoryIndex, section: 0)
        bigCategoryCollectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: .init(rawValue: 0))
    }
 

}

extension CategoryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bigCategoryCollectionView {
             return CGSize(width: self.view.frame.width / 4, height: bigCategoryView.frame.height)
        }
        else {
            let rectSize = self.view.frame.width / 3
            return CGSize(width: rectSize, height: rectSize)
        }
       
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == smallCategoryCollectionView {
            return 1
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bigCategoryCollectionView {
            return bigCategory.count
        }
        else {
            return categoryTextArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bigCategoryCollectionView {
            let cell = bigCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: bigCellId, for: indexPath) as! BigCategoryCell
            cell.tintColor = UIColor.rgb(red: 173, green: 173, blue: 173)
            cell.bigCategoryLabel.text = bigCategory[indexPath.item]
            return cell
        } else {
            let cell = smallCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: smallCellId, for: indexPath) as! SmallCategoryCell
            
            cell.smallCategoryLabel.text = categoryTextArr[indexPath.row]
            
            cell.categoryImageView.image = UIImage(named: categoryImageArr[indexPath.row])
            cell.smallCategoryLabel.sizeToFit()
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == bigCategoryCollectionView {
            setupCategory(categoryIndex: indexPath.item)
            bigCategoryIndex = indexPath.item
            if indexPath.row == 0 {
                categoryTextArr = fruitArr
                categoryImageArr = fruitImgaeArr
            } else if indexPath.row == 1 {
                categoryTextArr = cerealArr
                categoryImageArr = cerealImageArr
            } else if indexPath.row == 2 {
                categoryTextArr = vegetableArr
                categoryImageArr = vegetableImageArr
            } else {
                categoryTextArr = eggArr
                categoryImageArr = eggImageArr
                
            }
            smallCategoryCollectionView.reloadData()
        } else {
            let destvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
            var subIndex = 0
            destvc.navigationItem.title = categoryTextArr[indexPath.item]
            destvc.navigationController?.navigationBar.tintColor = .white
            destvc.mainId = bigCategoryIndex + 1
            switch bigCategoryIndex {
            case 0:
                subIndex = indexPath.item + 1
            case 1:
                subIndex = indexPath.item + 6
            case 2:
                subIndex = indexPath.item + 9
            case 3:
                subIndex = indexPath.item + 17
            default:
                break
            }
            print(subIndex)
            destvc.subId = subIndex
            self.navigationController?.pushViewController(destvc, animated: true)
            
        }
    }
}
