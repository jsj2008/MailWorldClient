#import "IntroControll.h"
#define inMargin 10.0

@implementation IntroControll


- (id)initWithFrame:(CGRect)frame pages:(NSArray*)pagesArray
{
    self = [super initWithFrame:frame];
    if(self != nil) {
        
        //Initial Background images
        
        self.backgroundColor = [UIColor whiteColor];
        
        backgroundImage1 = [[EMAsyncImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [backgroundImage1 setContentMode:UIViewContentModeScaleAspectFill];
//        [backgroundImage1 setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
        [self addSubview:backgroundImage1];

        backgroundImage2 = [[EMAsyncImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [backgroundImage2 setContentMode:UIViewContentModeScaleAspectFill];
//        [backgroundImage2 setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
        [self addSubview:backgroundImage2];
        
        //Initial shadow
//        UIImageView *shadowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow.png"]];
//        shadowImageView.contentMode = UIViewContentModeScaleToFill;
//        shadowImageView.frame = CGRectMake(0, frame.size.height-15, frame.size.width, 30);
//        [self addSubview:shadowImageView];
        
        //Initial ScrollView
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        
        //Initial PageView
        pageControl = [[UIPageControl alloc] init];
        pageControl.numberOfPages = pagesArray.count;
        [pageControl sizeToFit];
        [pageControl setCenter:CGPointMake(frame.size.width/2.0, frame.size.height-8)];
        [self addSubview:pageControl];
        
        //Create pages
        pages = pagesArray;
        
        scrollView.contentSize = CGSizeMake(pages.count * frame.size.width, frame.size.height);
        
        currentPhotoNum = -1;
        
        //insert TextViews into ScrollView
        for(int i = 0; i <  pages.count; i++) {
//            IntroView *view = [[IntroView alloc] initWithFrame:frame model:[pages objectAtIndex:i]];
            IntroView *view = [pages objectAtIndex:i];
            view.frame = CGRectOffset(view.frame, i*frame.size.width, 0);
            
            [scrollView addSubview:view];
        }
            
        //start timer
        timer =  [NSTimer scheduledTimerWithTimeInterval:5.0
                        target:self
                        selector:@selector(tick)
                        userInfo:nil
                        repeats:YES];
        
        [self initShow];
    }
    
    return self;
}

- (void) tick {
    [scrollView setContentOffset:CGPointMake((currentPhotoNum+1 == pages.count ? 0 : currentPhotoNum+1)*self.frame.size.width, 0) animated:YES];
}

- (void) initShow {
    int scrollPhotoNumber = MAX(0, MIN(pages.count-1, (int)(scrollView.contentOffset.x / self.frame.size.width)));
    
    if(scrollPhotoNumber != currentPhotoNum) {
        currentPhotoNum = scrollPhotoNumber;
        
//        EMAsyncImageView *image1 = [[EMAsyncImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        backgroundImage1.imageUrl = [(IntroView*)[pages objectAtIndex:currentPhotoNum] image];
//        backgroundImage1.image = image1.image;
        
        //        EMAsyncImageView *image2 = [[EMAsyncImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        backgroundImage2.imageUrl = currentPhotoNum+1 != [pages count] ? [(IntroView*)[pages objectAtIndex:currentPhotoNum+1] image] : nil;
//        backgroundImage2.image = image2.image;
    }
    
    float offset =  scrollView.contentOffset.x - (currentPhotoNum * self.frame.size.width);
    
    
    //left
    if(offset < 0) {
        pageControl.currentPage = 0;
        
        offset = self.frame.size.width - MIN(-offset, self.frame.size.width);
        backgroundImage2.alpha = 0;
        backgroundImage1.alpha = (offset / self.frame.size.width);
    
    //other
    } else if(offset != 0) {
        //last
        if(scrollPhotoNumber == pages.count-1) {
            pageControl.currentPage = pages.count-1;
            
            backgroundImage1.alpha = 1.0 - (offset / self.frame.size.width);
        } else {
            
            pageControl.currentPage = (offset > self.frame.size.width/2) ? currentPhotoNum+1 : currentPhotoNum;
            
            backgroundImage2.alpha = offset / self.frame.size.width;
            backgroundImage1.alpha = 1.0 - backgroundImage2.alpha;
        }
    //stable
    } else {
        pageControl.currentPage = currentPhotoNum;
        backgroundImage1.alpha = 1;
        backgroundImage2.alpha = 0;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scroll {
    [self initShow];
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scroll {
    if(timer != nil) {
        [timer invalidate];
        timer = nil;
    }
    [self initShow];
}

@end
