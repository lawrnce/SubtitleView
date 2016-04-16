//
//  SubtitleView.swift
//  Pods
//
//  Created by Lawrence Tran on 4/15/16.
//
//

import UIKit

public protocol SubtitleViewDelegate {
    
}

public class SubtitleView: UIView {
    
    var delegate: SubtitleViewDelegate?
    
    var textView: UITextView!
    
    private var placeholderLabel: UILabel!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        self.backgroundColor = UIColor.clearColor()
        setupTextView()
        self.addSubview(self.textView)
    }
    
    private func setupTextView() {
        self.textView = UITextView(frame: CGRect(x: 0,
            y: frame.height * 0.75,
            width: frame.width,
            height: frame.height * 0.25))
        self.textView.delegate = self
        self.textView.scrollEnabled = false
        self.textView.textAlignment = .Center
        self.textView.font = UIFont(name: "Arial-Bold", size: 26.0)
        self.textView.backgroundColor = UIColor.cyanColor()
    }
    
    private func setupPlaceholderLabel() {
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

extension SubtitleView: UITextViewDelegate {
    
}
