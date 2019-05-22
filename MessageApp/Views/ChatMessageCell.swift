//
//  ChatMessageCell.swift
//  MessageApp
//
//  Created by Глеб Гусаков on 18/05/2019.
//  Copyright © 2019 Глеб Гусаков. All rights reserved.
//

import UIKit

class ChatMessageCell: UICollectionViewCell {
    
    static let myColor = UIColor(r: 148, g: 141, b: 182)
    
        let textView: UITextView = {
            let tv = UITextView()
            tv.text = "SAMPLE TEXT FOR NOW"
            tv.font = UIFont.systemFont(ofSize: 16)
            tv.translatesAutoresizingMaskIntoConstraints = false
            tv.backgroundColor = UIColor.clear
            tv.textColor = .white
            return tv
        }()
        
        let bubbleView: UIView = {
            let view = UIView()
            view.backgroundColor = myColor
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.cornerRadius = 16
            view.layer.masksToBounds = true
            return view
        }()
        
        var bubbleWidthAnchor: NSLayoutConstraint?
        var bubbleViewRightAnchor: NSLayoutConstraint?
        var bubbleViewLeftAnchor: NSLayoutConstraint?
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(bubbleView)
            addSubview(textView)

            //x,y,w,h
            bubbleViewRightAnchor = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
            bubbleViewRightAnchor?.isActive = true
            bubbleViewLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8)
            bubbleViewLeftAnchor?.isActive = true
            bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
            bubbleWidthAnchor?.isActive = true
            bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
            textView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
            textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            textView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
            textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
