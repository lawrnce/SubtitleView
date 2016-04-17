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
    private var initialFontSize: CGFloat!
    private var fontSize: CGFloat!

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
        self.initialFontSize = dynamicFontSize()
        self.fontSize = self.initialFontSize
        self.textView.delegate = self
        self.textView.scrollEnabled = false
        self.textView.font = UIFont(name: "Arial-BoldItalicMT", size: self.initialFontSize)
        self.textView.textAlignment = .Center
        self.textView.textContainer.maximumNumberOfLines = 2
        self.textView.backgroundColor = UIColor.clearColor()
        self.textView.textContainerInset = UIEdgeInsetsZero
    }
    
    private func setupPlaceholderLabel() {
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func dynamicFontSize() -> CGFloat {
        let normalizer = CGFloat(240.0 / 20.0)
//        let fontScale = CGFloat(20.0)
        let scaleFactor = self.frame.width / normalizer
        return scaleFactor
    }
}

extension SubtitleView: UITextViewDelegate {
    
    public func textViewDidChange(textView: UITextView) {
        let string = NSAttributedString(string: textView.text, attributes: [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSStrokeWidthAttributeName : NSNumber(float: -2.0),
            NSFontAttributeName : UIFont(name: "Arial-BoldItalicMT", size: self.fontSize)!
            ])
        self.textView.attributedText =  string
        self.textView.textAlignment = .Center
        
        print(string.size().height)
    }
    
    private func sizeOfString (string: String, constrainedToWidth width: Double, font: UIFont) -> CGSize {
        return (string as NSString).boundingRectWithSize(CGSize(width: width, height: DBL_MAX),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: font],
            context: nil).size
    }
    
    public func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).stringByReplacingCharactersInRange(range, withString: text)
        var textWidth = CGRectGetWidth(UIEdgeInsetsInsetRect(textView.frame, textView.textContainerInset))
        textWidth -= 2.0 * textView.textContainer.lineFragmentPadding;
        let boundingRect = sizeOfString(newText, constrainedToWidth: Double(textWidth), font: textView.font!)
        let numberOfLines = boundingRect.height / textView.font!.lineHeight;
        return numberOfLines <= 2;
    }
}




