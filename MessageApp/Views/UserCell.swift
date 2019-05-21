//
//  UserCell.swift
//  MessageApp
//
//  Created by Глеб Гусаков on 18/05/2019.
//  Copyright © 2019 Глеб Гусаков. All rights reserved.
//
import UIKit
import Foundation
import Firebase

class UserCell: UITableViewCell {
    
    var message: Message? {
        didSet {
            if let toId = message?.toId {
                let ref = Database.database().reference().child("users").child(toId)
                ref.observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        self.textLabel?.text = dictionary["name"] as? String
//                        if let profileImageUrl = dictionary["profileImageUrl"] as? String {
//                            self.profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
//                        }
                    }
                    
                }, withCancel: nil)
            }
            detailTextLabel?.text = message?.text
            if let seconds = message?.timestamp?.doubleValue {
                let timestampDate = Date(timeIntervalSince1970: seconds)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm:ss a"
                timeLabel.text = dateFormatter.string(from: timestampDate)
            }
        }
    }
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "HH:MM:SS"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
        detailTextLabel?.frame = CGRect(x: 64, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubview(timeLabel)
        SetupTimeLabelView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func SetupTimeLabelView() {
        timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 18).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: textLabel!.heightAnchor).isActive = true
    }
    
}
