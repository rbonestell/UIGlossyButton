//
//  UIGlossyButton.m
//  iOS Glossy Buttons
//
//  Created by Robert Bonestell on 7/27/12.
//  Copyright (c) 2012 Robert Bonestell. All rights reserved.
//

#import "UIGlossyButton.h"

@implementation UIGlossyButton

- (void)awakeFromNib
{
    [self initLayers];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
        [self initLayers];
    return self;
}

- (void)initLayers
{
    [self initShadow];
	[self roundCorners];
    [self addGlossyLayer];
}

- (void)roundCorners
{
    self.layer.cornerRadius = 6;
}

- (void)initShadow
{
    [self.layer setShadowOffset:CGSizeMake(3, 3)];
    [self.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [self.layer setShadowOpacity:0.5];
    [self.layer setShadowPath:[UIBezierPath bezierPathWithRect:self.layer.bounds].CGPath];
}

- (void)addGlossyLayer
{
    if (!glossyLayer)
    {
        glossyLayer = [CAGradientLayer layer];
        glossyLayer.frame = self.layer.bounds;
        glossyLayer.colors = [NSArray arrayWithObjects:
                              (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                              (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                              (id)[UIColor colorWithWhite:0.75f alpha:0.2f].CGColor,
                              (id)[UIColor colorWithWhite:0.4f alpha:0.2f].CGColor,
                              (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                              nil];
        glossyLayer.locations = [NSArray arrayWithObjects:
                                 [NSNumber numberWithFloat:0.0f],
                                 [NSNumber numberWithFloat:0.5f],
                                 [NSNumber numberWithFloat:0.5f],
                                 [NSNumber numberWithFloat:0.8f],
                                 [NSNumber numberWithFloat:1.0f],
                                 nil];
        glossyLayer.cornerRadius = self.layer.cornerRadius;
    }
    if (![[self.layer sublayers] containsObject:glossyLayer])
        [self.layer addSublayer:glossyLayer]; 
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesBegan:touches withEvent:event];
	[CATransaction begin];
	[CATransaction setValue:[NSNumber numberWithFloat:0.0f] forKey:kCATransactionAnimationDuration];
	[glossyLayer setAffineTransform:CGAffineTransformMakeScale(1, -1)];
	[CATransaction commit];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesEnded:touches withEvent:event];
	[CATransaction begin];
	[CATransaction setValue:[NSNumber numberWithFloat:0.0f] forKey:kCATransactionAnimationDuration];
	[glossyLayer setAffineTransform:CGAffineTransformMakeScale(1, 1)];
	[CATransaction commit];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [glossyLayer setFrame:self.layer.bounds];
    [self.layer setShadowPath:[UIBezierPath bezierPathWithRect:self.layer.bounds].CGPath];
}

@end
