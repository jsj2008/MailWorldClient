#import <UIKit/UIKit.h>
#import "EMAsyncImageView.h"
#import "IntroView.h"

@interface IntroControll : UIView<UIScrollViewDelegate> {
    EMAsyncImageView *backgroundImage1;
    EMAsyncImageView *backgroundImage2;
    
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    NSArray *pages;
    
    NSTimer *timer;
    
    int currentPhotoNum;
    
    UIView *contentView;
}

- (id)initWithFrame:(CGRect)frame pages:(NSArray*)pages;


@end
