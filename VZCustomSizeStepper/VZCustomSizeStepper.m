//
//  VZCustomSizeStepper.m
//  FillMoji
//
//  Created by Vyacheslav Zubenko on 26/11/16.
//  Copyright © 2016 Vyacheslav Zubenko. All rights reserved.
//

#import "VZCustomSizeStepper.h"

@implementation VZCustomSizeStepper

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - Initialization

// -----------------------------------------------------------------------------
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        CGSize size = CGSizeMake(frame.size.height, frame.size.height);
        self.layer.cornerRadius = self.frame.size.height*0.3;
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = self.tintColor.CGColor;
        [self setIncrementImage:[self imageWithString:@"+" size:size] forState:UIControlStateNormal];
        [self setDecrementImage:[self imageWithString:@"−" size:size] forState:UIControlStateNormal];
        [self setBackgroundImage:[self imageForSize:frame.size and:[UIColor clearColor]] forState:UIControlStateNormal];
        [self setBackgroundImage:[self imageForSize:frame.size and:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
         [self setBackgroundImage:[self imageForSize:frame.size and:[UIColor clearColor]] forState:UIControlStateDisabled];
 
        
    }
    
    return self;
}

//

#pragma mark - generate images

// -----------------------------------------------------------------------------
- (UIImage *)imageForSize:(CGSize)size and:(UIColor*)color {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
//    [self drawRect:rect cornerRadius:self.layer.cornerRadius color:color];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    image = [self imageWithRoundedCornersSize:self.layer.cornerRadius usingImage:image];
    return image;
}


- (UIImage *)imageWithString:(NSString *)aString size:(CGSize)aSize
{
    
    if (aString && aString.length) {
        
    }
    else {
        return nil;
    }
    
    CGFloat fWidth = aSize.width;
    CGFloat fHeight = aSize.height;
    CGFloat fontSize = aSize.width;
    UIColor* fillColor = [UIColor clearColor];
    
    UIGraphicsBeginImageContextWithOptions(aSize, NO, 2.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [fillColor CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, fWidth, fHeight));
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGFloat yOffset = (aSize.height - (font.capHeight + font.xHeight)*0.5) / 2.0;
    CGRect textRect = CGRectMake(0, -yOffset, aSize.height, fontSize);
    NSDictionary *d = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor whiteColor]};
    NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:aString attributes:d];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    [s addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, aString.length)];
    
    [s drawInRect:textRect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//http://stackoverflow.com/questions/10563986/uiimage-with-rounded-corners
- (UIImage *)imageWithRoundedCornersSize:(float)cornerRadius usingImage:(UIImage *)original
{
    CGRect frame = CGRectMake(0, 0, original.size.width, original.size.height);
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContextWithOptions(original.size, NO, original.scale);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:frame
                                cornerRadius:cornerRadius] addClip];
    // Draw your image
    [original drawInRect:frame];
    
    // Get the image, here setting the UIImageView image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return image;
}
@end
