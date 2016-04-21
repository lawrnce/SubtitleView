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
    
    private var textView: UITextView!
    private var placeholderLabel: UILabel!
    private var initialFontSize: CGFloat!
    private var fontSize: CGFloat!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override func resignFirstResponder() -> Bool {
        return self.textView.resignFirstResponder()
    }
    
    private func setup() {
        self.backgroundColor = UIColor.clearColor()
        self.initialFontSize = dynamicFontSize()
        setupTextView()
        setupPlaceholderLabel()
    }
    
    private func setupTextView() {
        self.textView = UITextView(frame: CGRect(x: 0,
            y: frame.height * 0.9,
            width: frame.width,
            height: frame.height * 0.1))
        self.fontSize = self.initialFontSize
        self.textView.delegate = self
        self.textView.scrollEnabled = false
        self.textView.font = UIFont(name: "Arial-BoldItalicMT", size: self.initialFontSize)
        self.textView.textAlignment = .Center
        self.textView.textContainer.maximumNumberOfLines = 2
        self.textView.backgroundColor = UIColor.clearColor()
        self.textView.textContainerInset = UIEdgeInsetsZero
        self.addSubview(self.textView)
    }
    
    private func setupPlaceholderLabel() {
        self.placeholderLabel = UILabel(frame: CGRectZero)
        let string = NSAttributedString(string: "Add Subtitle", attributes: [
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue,
            NSFontAttributeName : UIFont(name: "Arial-ItalicMT", size: self.initialFontSize - 4.0)!
            ])
        self.placeholderLabel.attributedText = string
        self.placeholderLabel.sizeToFit()
        self.placeholderLabel.center = CGPointMake(self.textView.center.x, self.textView.center.y)
        self.addSubview(self.placeholderLabel)
    }
    
    private func dynamicHeightSize() {
    
    }
    
    private func dynamicFontSize() -> CGFloat {
        let scaleFactor = CGFloat(240.0 / 19.0)
        return self.frame.width / scaleFactor
    }
    
    private func sizeOfString (string: String, constrainedToWidth width: Double, font: UIFont) -> CGSize {
        return (string as NSString).boundingRectWithSize(CGSize(width: width, height: DBL_MAX),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: font],
            context: nil).size
    }
    
    private func renderFrame() {
        
    }
}

extension SubtitleView: UITextViewDelegate {
    
    public func textViewDidBeginEditing(textView: UITextView) {
        self.placeholderLabel.hidden = true
    }
    
    public func textViewDidEndEditing(textView: UITextView) {
        self.placeholderLabel.hidden = !textView.text.isEmpty
    }
    
    public func textViewDidChange(textView: UITextView) {
        if (textView.text.isEmpty == false) {
            let string = NSAttributedString(string: textView.text, attributes: [
                NSStrokeColorAttributeName : UIColor.blackColor(),
                NSForegroundColorAttributeName : UIColor.whiteColor(),
                NSStrokeWidthAttributeName : NSNumber(float: -2.0),
                NSFontAttributeName : UIFont(name: "Arial-BoldItalicMT", size: self.fontSize)!
                ])
            textView.attributedText =  string
            textView.textAlignment = .Center
        }
    }
    
    public func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).stringByReplacingCharactersInRange(range, withString: text)
        var textWidth = CGRectGetWidth(UIEdgeInsetsInsetRect(textView.frame, textView.textContainerInset))
        textWidth -= 2.0 * textView.textContainer.lineFragmentPadding;
        let boundingRect = sizeOfString(newText, constrainedToWidth: Double(textWidth), font: textView.font!)
        let numberOfLines = boundingRect.height / textView.font!.lineHeight;
        
        if (numberOfLines <= 2) {
            if (numberOfLines == 1) {
                textView.frame = CGRect(x: 0, y: frame.height * 0.9, width: frame.width, height: frame.height * 0.1)
            } else if (numberOfLines == 2){
                textView.frame = CGRect(x: 0, y: frame.height * 0.8, width: frame.width, height: frame.height * 0.2)
            }
            return true
        } else {
            return false
        }
    }
}