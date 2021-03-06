//
//  SignUpInfo1VC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 8..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class SignUpInfo1VC: UIViewController {
    
    
    @IBOutlet var logoImg: UIImageView!
    @IBOutlet var logoLabel: UILabel!
    @IBOutlet var logoStack: UIStackView!
    @IBOutlet var infoStack: UIStackView!
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var yearTxtFd: UITextField!
    @IBOutlet var monthTxtFd: UITextField!
    @IBOutlet var dayTxtFd: UITextField!
    @IBOutlet var nameTxtFd: UITextField!

    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.locale = .current
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoStack.hero.id = "stack"
        nextButton.hero.id = "next"
        infoStack.hero.modifiers = [.translate(x: 100), .fade]
        nextButton.applyRadius(radius: nextButton.frame.height/2)
        initGestureRecognizer()
        setupPicker()
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        
        if yearTxtFd.text == "" || nameTxtFd.text == "" {
            simpleAlert(title: "모든 항목을 입력해주세요!", message: "")
        } else {
            let signupVC = UIStoryboard(name: "Sign", bundle: nil).instantiateViewController(withIdentifier: "SignUpInfo2VC") as! SignUpInfo2VC
            
            signupVC.birth = yearTxtFd.text! + "/" + monthTxtFd.text! + "/" + dayTxtFd.text!
            signupVC.user_name = nameTxtFd.text!
            self.present(signupVC, animated: true, completion: nil)
        }
    }
    
    private func setupPicker() {
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        toolbar.barTintColor = UIColor.white
        let doneButton = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(donePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelPicker));
        doneButton.tintColor = .rgb(red: 82, green: 156, blue: 119)
        cancelButton.tintColor = .rgb(red: 212, green: 84, blue: 133)
        doneButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFEB", size: 15)!], for: .normal)
        cancelButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFEB", size: 15)!], for: .normal)
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        yearTxtFd.inputAccessoryView = toolbar
        yearTxtFd.inputView = datePicker
        monthTxtFd.inputAccessoryView = toolbar
        monthTxtFd.inputView = datePicker
        dayTxtFd.inputAccessoryView = toolbar
        dayTxtFd.inputView = datePicker
    }
    
    @objc func donePicker() {
        let yearFormatter = DateFormatter()
        let monthFormatter = DateFormatter()
        let dayFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        monthFormatter.dateFormat = "MM"
        dayFormatter.dateFormat = "dd"
        yearTxtFd.text = yearFormatter.string(from: datePicker.date)
        monthTxtFd.text = monthFormatter.string(from: datePicker.date)
        dayTxtFd.text = dayFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelPicker() {
        self.view.endEditing(true)
    }

}

extension SignUpInfo1VC: UIGestureRecognizerDelegate {
    
    func initGestureRecognizer() {
        let mainTap = UITapGestureRecognizer(target: self, action: #selector(handleTabMainView(_:)))
        mainTap.delegate = self
        view.addGestureRecognizer(mainTap)
    }
    
    @objc func handleTabMainView(_ sender: UITapGestureRecognizer){
        self.nameTxtFd.resignFirstResponder()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: nameTxtFd))! {
            return false
        }
        return true
    }
}
