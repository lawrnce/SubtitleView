//
//  SubtitleView.swift
//  Pods
//
//  Created by Lawrence Tran on 4/15/16.
//
//

import UIKit

protocol SubtitleViewDelegate {
    
}

class SubtitleView: UIView {
    
    var delegate: SubtitleViewDelegate?
    
    var textView: UITextView!
    
    private var placeholderLabel: UILabel!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.textView = UITextView(frame: CGRect(x: 0,
            y: frame.height * 0.75,
            width: frame.width,
            height: frame.height * 0.25))
        self.textView.delegate = self
        self.addSubview(self.textView)
    }
    
    // PRIVATE METHODS
    private func setupTextView() {
        
    }
    
    private func setupPlaceholderLabel() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension SubtitleView: UITextViewDelegate {
    
}
