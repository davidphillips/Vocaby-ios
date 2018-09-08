//
//  VocabyAlertView.swift
//  Vocaby
//
//  Created by David Phillips on 5/8/18.
//  Copyright © 2018 David Phillips. All rights reserved.
//

import Foundation
import UIKit

protocol VocabyAlertViewDelegate {
    func onButtonPress(_ vocabyAlertView: VocabyAlertView)
}

class VocabyAlertView: UIView, ModalView {
    var backgroundView: UIView = UIView()
    var dialogView: UIView = UIView()
    var textField: UITextField = UITextField()
    
    var delegate: VocabyAlertViewDelegate?
    
    convenience init(title: String) {
        self.init(frame: UIScreen.main.bounds)
        
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.4
        addSubview(backgroundView)
        
        let dialogViewWidth = backgroundView.frame.width - 64
        
        let titleLabel = UILabel(frame: CGRect(x: 8, y: 8, width: dialogViewWidth - 16, height: 40))
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 26.0)
        titleLabel.textColor = UIColor.white
        dialogView.addSubview(titleLabel)
        
        let separatorLineView = UIView()
        separatorLineView.frame.origin = CGPoint(x: 0, y: titleLabel.frame.height + 8)
        separatorLineView.frame.size = CGSize(width: dialogViewWidth, height: 2)
        separatorLineView.backgroundColor = UIColor.vocabyLightRed()
        dialogView.addSubview(separatorLineView)
        
        textField.frame.origin = CGPoint(x: 8, y: separatorLineView.frame.height + separatorLineView.frame.origin.y + 8)
        textField.frame.size = CGSize(width: dialogViewWidth - 16 , height: 44)
        textField.backgroundColor = UIColor.white
        textField.layer.cornerRadius = 4
        textField.clipsToBounds = true
        textField.textAlignment = .center
        textField.font = UIFont.boldSystemFont(ofSize: 20.0)
        dialogView.addSubview(textField)
        
        let button = UIButton()
        button.frame.origin = CGPoint(x: 8, y: separatorLineView.frame.height + separatorLineView.frame.origin.y + 8 + textField.frame.height + 8)
        button.frame.size = CGSize(width: dialogViewWidth - 16 , height: 44)
        button.setTitle("Add", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        button.titleLabel?.textColor = UIColor.white
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.backgroundColor = UIColor.vocabyLightRed()
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.vocabyDarkRed().cgColor;
        button.addTarget(self, action: #selector(onButtonPress), for: .touchUpInside)
        dialogView.addSubview(button)
        
        let dialogViewHeight = titleLabel.frame.height + 8 + separatorLineView.frame.height + 8 + textField.frame.height + 8 + button.frame.height + 8
        dialogView.frame.origin = CGPoint(x: 32, y: frame.height)
        dialogView.frame.size = CGSize(width: frame.width - 64, height: dialogViewHeight)
        dialogView.backgroundColor = UIColor.vocabyLightRed()
        dialogView.layer.cornerRadius = 6
        dialogView.clipsToBounds = true
        addSubview(dialogView)
        
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedOnBackgroundView)))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setDelegate(_ delegate: VocabyAlertViewDelegate) {
        self.delegate = delegate
    }
    
    @objc func onButtonPress() {
        self.delegate?.onButtonPress(self)
        dismiss(animated: true)
    }
    
    @objc func tappedOnBackgroundView() {
        dismiss(animated: true)
    }
    
    
}
