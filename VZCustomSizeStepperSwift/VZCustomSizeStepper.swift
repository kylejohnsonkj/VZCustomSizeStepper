//
//  VZCustomSizeStepper.swift
//  FillMoji
//
//  Created by Vyacheslav Zubenko on 26/11/16.
//  Copyright © 2016 Vyacheslav Zubenko. All rights reserved.
//

class VZCustomSizeStepper: UIStepper {

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let size = CGSize(width: frame.size.height, height: frame.size.height)
        layer.cornerRadius = 5
        layer.borderWidth = 1.0
        layer.borderColor = tintColor.cgColor
        setIncrementImage(image(with: "+", size: size), for: .normal)
        setDecrementImage(image(with: "−", size: size), for: .normal)
        setBackgroundImage(image(for: frame.size, and: .clear), for: .normal)
        setBackgroundImage(image(for: frame.size, and: .lightGray), for: .highlighted)
        setBackgroundImage(image(for: frame.size, and: .clear), for: .disabled)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - generate images
    func image(for size: CGSize, and color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return self.image(withRoundedCornersSize: Float(layer.cornerRadius), using: image)
    }
    
    func image(with aString: String?, size aSize: CGSize) -> UIImage? {
        guard aString != nil && (aString?.count ?? 0) != 0 else {
            return nil
        }
        let fWidth = aSize.width
        let fHeight = aSize.height
        let fontSize = aSize.width
        let fillColor = UIColor.clear
        
        UIGraphicsBeginImageContextWithOptions(aSize, _: false, _: 2.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(fillColor.cgColor)
        context?.fill(CGRect(x: 0, y: 0, width: fWidth, height: fHeight))
        let font = UIFont.systemFont(ofSize: fontSize)
        let yOffset = (aSize.height - (font.capHeight + font.xHeight) * 0.5) / 2.0
        let textRect = CGRect(x: 0, y: -yOffset, width: aSize.height, height: fontSize)
        let d = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        let s = NSMutableAttributedString(string: aString ?? "", attributes: d)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        s.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: aString?.count ?? 0))
        s.draw(in: textRect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    // http://stackoverflow.com/questions/10563986/uiimage-with-rounded-corners
    func image(withRoundedCornersSize cornerRadius: Float, using original: UIImage?) -> UIImage? {
        let frame = CGRect(x: 0, y: 0, width: original?.size.width ?? 0.0, height: original?.size.height ?? 0.0)
        
        // Begin a new image that will be the new image with the rounded corners
        // (here with the size of an UIImageView)
        UIGraphicsBeginImageContextWithOptions(original?.size ?? CGSize.zero, _: false, _: original?.scale ?? 0.0)
        
        // Add a clip before drawing anything, in the shape of an rounded rect
        UIBezierPath(roundedRect: frame, cornerRadius: CGFloat(cornerRadius)).addClip()
        // Draw your image
        original?.draw(in: frame)
        
        // Get the image, here setting the UIImageView image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        // Lets forget about that we were drawing
        UIGraphicsEndImageContext()
        
        return image
    }
}
