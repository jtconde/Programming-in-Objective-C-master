//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Akshay on 1/8/13.
//  Copyright (c) 2013 Gallifrey. All rights reserved.
//

#import "HypnosisView.h"

@implementation HypnosisView

@synthesize circleColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setCircleColor:[UIColor lightGrayColor]];
    }
    
    return self;
}

- (void)setCircleColor:(UIColor *)clr
{
    circleColor = clr;
    [self setNeedsDisplay];
}

/**
 * Colors the circles in random colors
 * Returns a random color
 * Chapter 4 Bronze Challenge: Colors
 */
- (UIColor *)getAssortedColors
{
    NSArray *assortedColors = [NSArray arrayWithObjects:[UIColor redColor],
                               [UIColor magentaColor], [UIColor blueColor],
                               [UIColor yellowColor], [UIColor orangeColor],
                               [UIColor cyanColor], [UIColor greenColor],
                               [UIColor purpleColor], nil];
    return [assortedColors objectAtIndex:random() % [assortedColors count]];
}

- (void)drawRect:(CGRect)dirtyRect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect bounds = [self bounds];
    
    CGPoint center;
    // The center of the bounds rectangle
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    // The radius of the circle should be nearly as big as the view
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    CGContextSetLineWidth(ctx, 10);
    
    // draw concentric circles from the outside in
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -=20)
    {
        // add a path to the context
        CGContextAddArc(ctx, center.x, center.y, currentRadius, 0.0, M_PI * 2.0,
                        YES);
        [[self getAssortedColors] setStroke];
        
        // Perform drawing instruction; clears path
        CGContextStrokePath(ctx);
    }
    
    // Create a string
    NSString *text = @"You are getting sleepy.";
    
    // Use a font for the text
    UIFont *font = [UIFont boldSystemFontOfSize:28];
    
    CGRect textRect;
    
    // How big is this string when drawn in this font?
    textRect.size = [text sizeWithFont:font];
    
    // Put that string in the center of the view
    textRect.origin.x = center.x - textRect.size.width / 2.0;
    textRect.origin.y = center.y - textRect.size.height / 2.0;
    
    [[UIColor blackColor] setFill];
    
    // Shadow will move 4 points to the right and 3 points down from the text
    CGSize offset = CGSizeMake(4, 3);
    CGColorRef color = [[UIColor grayColor] CGColor];
    
    CGContextSetShadowWithColor(ctx, offset, 2.0, color);
    
    // draw the string
    [text drawInRect:textRect withFont:font];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"Device started shaking!");
        [self setCircleColor:[UIColor redColor]];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

@end
