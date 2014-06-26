//  UnderLineLabel.m

#import "UnderLineLabel.h"

@implementation UnderLineLabel

@synthesize normalColor = _normalColor;
@synthesize highlightedColor = _highlightedColor;
@synthesize shouldUnderline = _shouldUnderline;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)init
{
    if (self = [super init]) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

- (void)setShouldUnderline:(BOOL)shouldUnderline
{
    _shouldUnderline = shouldUnderline;
    if (_shouldUnderline) {
        [self setup];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.shouldUnderline) {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGSize fontSize =[self.text sizeWithFont:self.font
                                        forWidth:self.frame.size.width
                                   lineBreakMode:NSLineBreakByTruncatingTail];
        
        CGContextSetStrokeColorWithColor(ctx, self.normalColor.CGColor);  // set as the text's color
        CGContextSetLineWidth(ctx, 2.0f);
        
        CGPoint leftPoint = CGPointMake(0,
                                        self.frame.size.height);
        CGPoint rightPoint = CGPointMake(fontSize.width,
                                         self.frame.size.height);
        CGContextMoveToPoint(ctx, leftPoint.x, leftPoint.y);
        CGContextAddLineToPoint(ctx, rightPoint.x, rightPoint.y);
        CGContextStrokePath(ctx);
    }
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    self.textColor = self.normalColor;
}

- (void)setup
{
    [self setUserInteractionEnabled:TRUE];
    _actionView = [[UIControl alloc] initWithFrame:self.bounds];
    [_actionView setBackgroundColor:[UIColor clearColor]];
    [_actionView addTarget:self action:@selector(appendHighlightedColor) forControlEvents:UIControlEventTouchDown];
    [_actionView addTarget:self
                    action:@selector(removeHighlightedColor)
          forControlEvents:UIControlEventTouchCancel |
     UIControlEventTouchUpInside |
     UIControlEventTouchDragOutside |
     UIControlEventTouchUpOutside];
    [self addSubview:_actionView];
    [self sendSubviewToBack:_actionView];
}

- (void)addTarget:(id)target action:(SEL)action
{
    [_actionView addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)appendHighlightedColor
{
    self.textColor = self.highlightedColor;
}

- (void)removeHighlightedColor
{
    self.textColor = self.normalColor;
}

@end







