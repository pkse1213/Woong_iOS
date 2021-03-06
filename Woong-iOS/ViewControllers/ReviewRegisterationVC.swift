//
//  ReviewRegisterationVC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 4..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class ReviewRegisterationVC: UIViewController {
    @IBOutlet weak var reviewScrollView: UIScrollView!
    @IBOutlet var reviewView: UIView!
    @IBOutlet var reviewTextView: UITextView!
    @IBOutlet var reviewImageCollectionView: UICollectionView!
    
    @IBOutlet weak var textReviewOkButton: UIButton!
    
    @IBOutlet var deliveryButtonArr: [UIButton]!
    @IBOutlet var tastyButtonArr: [UIButton]!
    @IBOutlet var refreshButtonArr: [UIButton]!
    @IBOutlet var kindButtonArr: [UIButton]!
    
    @IBOutlet weak var deliveryRateLabel: UILabel!
    @IBOutlet weak var tastyRateLabel: UILabel!
    @IBOutlet weak var refreshRateLabel: UILabel!
    @IBOutlet weak var kindRateLabel: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var cancelBarItem: UIBarButtonItem!
    
    @IBOutlet weak var registerationBarItem: UIBarButtonItem!
    
    let imagePicker : UIImagePickerController = UIImagePickerController()
    let unlikeImage = UIImage(named: "alarm-reviewing-not-like")
    let likeImage = UIImage(named: "alarm-reviewing-like")
    
    let rateTextArr = ["별로에요","보통이에요","만족해요","정말좋아요","완벽해요"]
    var reviewImageArr: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textReviewOkButton.isHidden = true
        setupTextView()
        setupCollectionView()
        navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFEB", size: 17)!]
        cancelBarItem.setTitleTextAttributes([
            NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFB", size: 15)!,
            NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.3215686275, green: 0.6117647059, blue: 0.4666666667, alpha: 1)], for: .normal)
        registerationBarItem.setTitleTextAttributes([
            NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFB", size: 15)!,
            NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.3215686275, green: 0.6117647059, blue: 0.4666666667, alpha: 1)], for: .normal)
    }
    
    @IBAction func deliveryLatingAction(_ sender: UIButton) {
        var index = 5
        for i in 0...4 {
            if sender == deliveryButtonArr[i] {
                deliveryRateLabel.text = rateTextArr[i]
                index = i
            }
            
            if i > index {
                deliveryButtonArr[i].setBackgroundImage(unlikeImage, for: .normal)
            } else {
                deliveryButtonArr[i].setBackgroundImage(likeImage, for: .normal)
            }
        }
    }
    
    @IBAction func tastyLatingAction(_ sender: UIButton) {
        var index = 5
        for i in 0...4 {
            if sender == tastyButtonArr[i] {
                tastyRateLabel.text = rateTextArr[i]
                 index = i
            }
            
            if i > index {
                tastyButtonArr[i].setBackgroundImage(unlikeImage, for: .normal)
            } else {
                tastyButtonArr[i].setBackgroundImage(likeImage, for: .normal)
            }
        }
    }
    
    @IBAction func kindLatingAction(_ sender: UIButton) {
        var index = 5
        for i in 0...4 {
            if sender == kindButtonArr[i] {
                kindRateLabel.text = rateTextArr[i]
                index = i
            }
            
            if i > index {
                kindButtonArr[i].setBackgroundImage(unlikeImage, for: .normal)
            } else {
                kindButtonArr[i].setBackgroundImage(likeImage, for: .normal)
            }
        }
    }
    
    @IBAction func refreshLatingAction(_ sender: UIButton) {
        var index = 5
        for i in 0...4 {
            if sender == refreshButtonArr[i] {
                refreshRateLabel.text = rateTextArr[i]
                index = i
            }
            
            if i > index {
                refreshButtonArr[i].setBackgroundImage(unlikeImage, for: .normal)
            } else {
                refreshButtonArr[i].setBackgroundImage(likeImage, for: .normal)
            }
        }
    }
    
    private func setupTextView() {
        reviewTextView.delegate = self
        reviewTextView.sizeToFit()
        if reviewTextView.text == "" {
            textViewDidEndEditing(reviewTextView)
        }
        
        let tapDidsmiss = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.reviewView.addGestureRecognizer(tapDidsmiss)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    private func setupCollectionView(){
        reviewImageCollectionView.delegate = self
        reviewImageCollectionView.dataSource = self
    }
    @IBAction func openImagePicker(_ sender: UIButton) {
        openGallery()
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func textReviewOKAciton(_ sender: UIButton) {
        reviewTextView.resignFirstResponder()
    }
}

extension ReviewRegisterationVC: UITextViewDelegate {
    
    @objc func dismissKeyboard() {
        reviewTextView.resignFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "식품은 만족스러우셨나요? 식품의 장점과 아쉬운 점을 다른사람에게 알려주세요. 작성하신 후기는 지금 구매를 고민하는 사람에게 큰 도움이 됩니다."
            textView.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        textView.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "식품은 만족스러우셨나요? 식품의 장점과 아쉬운 점을 다른사람에게 알려주세요. 작성하신 후기는 지금 구매를 고민하는 사람에게 큰 도움이 됩니다." {
            textView.text = ""
            textView.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
        textView.becomeFirstResponder()
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        if let keyboardFrame: NSValue = sender.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y = -keyboardHeight
        }
        textReviewOkButton.isHidden = false
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
        textReviewOkButton.isHidden = true
    }
}

extension ReviewRegisterationVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewImageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = reviewImageCollectionView.dequeueReusableCell(withReuseIdentifier: "reviewImageCell", for: indexPath) as! reviewImageCell
        cell.reviewImageView.image = reviewImageArr[indexPath.row]
        cell.removeButton.tag = indexPath.row
        cell.removeButton.addTarget(self, action: #selector(deleteCellFromButton(button:)), for: .touchUpInside)
        
        return cell
    }
    @objc func deleteCellFromButton(button: UIButton) {
        reviewImageArr.remove(at: button.tag)
        reviewImageCollectionView.reloadData()
    }
}

extension ReviewRegisterationVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.delegate = self
            
            // false이면 이미지를 자르지 않고
            // true면 자유자제로 크롭 가능
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: { print("이미지 피커 나옴") })
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("사용자가 취소함")
        self.dismiss(animated: true) {
            print("이미지 피커 사라짐")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //        defer {
        //            self.dismiss(animated: true) {
        //                print("이미지 피커 사라짐")
        //            }
        //        }
        
        if let editedImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            reviewImageArr.append(editedImage)
        } else if let originalImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            reviewImageArr.append(originalImage)
        }
        self.dismiss(animated: true) {
          
            self.reviewImageCollectionView.reloadData()
        }
    }
//    func textViewDidChange(_ textView: UITextView) {
//        let size = CGSize(width: textView.frame.width, height: CGFloat(MAXFLOAT))
//        let value = textView.sizeThatFits(size)
//        let newHeight = value.height + textView.frame.minY
//        if newHeight > scrollView.contentSize.height {
//            contentView.frame = CGRect(x: 0, y: 0, width: textView.frame.width, height: newHeight)
//
//            scrollView.contentSize = CGSize(width: textView.frame.width, height: value.height + textView.frame.minY)
//        }
//    }
//

}
