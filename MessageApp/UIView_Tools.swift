//
//  UIView+Tools.swift
//  EntourageLink
//
//  Created by Nikita Zatsepilov on 14/03/2018.
//  Copyright © 2018 RamandeepSingh. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func findRootSuperView() -> UIView? {
        guard let superview = superview else { return nil }
        guard !(superview is UIWindow) else { return self }
        
        var view = self
        while let superview = view.superview, !(superview is UIWindow) {
            view = superview
        }
        
        return view
    }
    
    /// Method to pin edges of view to superview using Autolayout
    ///
    /// - Parameters:
    ///   - leading: Leading indent, default: nil (don't pin this edge)
    ///   - trailing: Trailing indent, default: nil (don't pin this edge)
    ///   - top: Top indent, default: nil (don't pin this edge)
    ///   - bottom: Bottom indent, default: nil (don't pin this edge)
    func pinAllEdgesToSuperview(leading: CGFloat = 0, trailing: CGFloat = 0, top: CGFloat = 0, bottom: CGFloat = 0) {
        guard let superview = superview else { return }

        translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superview, attribute: .leading, multiplier: 1, constant: leading),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: superview, attribute: .trailing, multiplier: 1, constant: trailing),
            NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1, constant: top),
            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 1, constant: bottom)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    /// Method to pin some (optional) edges of view to superview using Autolayout
    ///
    /// - Parameters:
    ///   - leading: Leading indent, default: nil (don't pin this edge)
    ///   - trailing: Trailing indent, default: nil (don't pin this edge)
    ///   - top: Top indent, default: nil (don't pin this edge)
    ///   - bottom: Bottom indent, default: nil (don't pin this edge)
    func pinSomeEdgesToSuperview(leading: CGFloat? = nil, trailing: CGFloat? = nil, top: CGFloat? = nil, bottom: CGFloat? = nil) {
        guard let superview = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        
        if let leading = leading {
            constraints.append(NSLayoutConstraint(
                item: self, attribute: .leading, relatedBy: .equal, toItem: superview, attribute: .leading, multiplier: 1, constant: leading
            ))
        }
        
        if let trailing = trailing {
            constraints.append(NSLayoutConstraint(
                item: self, attribute: .trailing, relatedBy: .equal, toItem: superview, attribute: .trailing, multiplier: 1, constant: trailing
            ))
        }
        
        if let top = top {
            constraints.append(NSLayoutConstraint(
                item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1, constant: top
            ))
        }
        
        if let bottom = bottom {
            constraints.append(NSLayoutConstraint(
                item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 1, constant: bottom
            ))
        }
        
        NSLayoutConstraint.activate(constraints)
    }

    @discardableResult
    func pin(edge : NSLayoutConstraint.Attribute, toAnotherView : UIView, anotherViewEdge : NSLayoutConstraint.Attribute, withConstant : CGFloat = 0, relatedBy: NSLayoutConstraint.Relation = .equal) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        let array = [NSLayoutConstraint(item: self, attribute: edge, relatedBy: relatedBy, toItem: toAnotherView, attribute: anotherViewEdge, multiplier: 1, constant: withConstant)]
        NSLayoutConstraint.activate(array)
        return array
    }

    @discardableResult
    func setHeightConstraint(height: CGFloat) -> NSLayoutConstraint {
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height)
        NSLayoutConstraint.activate([heightConstraint])
        return heightConstraint
    }

    @discardableResult
    func setWidthConstraint(width: CGFloat, relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: relation, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: width)
        NSLayoutConstraint.activate([widthConstraint])
        return widthConstraint
    }
    
    func setWidthEqual(toView : UIView) {
        NSLayoutConstraint.activate([NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: toView, attribute: .width, multiplier: 1, constant: 0)])
    }
}
