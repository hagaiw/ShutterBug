//
//  ImageViewController.m
//  Imaginarium
//
//  Created by CS193p Instructor.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController () <UIScrollViewDelegate, UISplitViewControllerDelegate>

/// The image to display.
@property (nonatomic, strong) UIImage *image;

/// \c UIImageView in which the image will be displayed.
@property (nonatomic, strong) UIImageView *imageView;

/// \c UIScrollView in which the image view is embedded.
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

/// \c spinner object that indicates that the image is loading.
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation PhotoViewController

#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.scrollView addSubview:self.imageView];
  [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
  [[NSNotificationCenter defaultCenter]
   addObserver:self selector:@selector(orientationChanged:)
   name:UIDeviceOrientationDidChangeNotification
   object:[UIDevice currentDevice]];
}

- (void) orientationChanged:(NSNotification *)note
{
  [self setScrollViewZoomRect];
}

#pragma mark -
#pragma mark Setter Methods
#pragma mark -

- (UIImageView *)imageView
{
  if (!_imageView) _imageView = [[UIImageView alloc] init];
  return _imageView;
}

- (UIImage *)image
{
  return self.imageView.image;
}

- (void)setImage:(UIImage *)image
{
  self.imageView.image = image;
  self.scrollView.zoomScale = 1.0;
  self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
  [self.spinner stopAnimating];
  
  [self setScrollViewZoomRect];
}

- (void)setScrollView:(UIScrollView *)scrollView
{
  _scrollView = scrollView;
  
  _scrollView.minimumZoomScale = 0.2;
  _scrollView.maximumZoomScale = 2.0;
  _scrollView.delegate = self;
  
  [self setScrollViewZoomRect];
}


#pragma mark -
#pragma mark Image Placement Handling
#pragma mark -

- (void)setScrollViewZoomRect {
  self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
  
  CGFloat screenWidthHeightRatio =
      [self.scrollView bounds].size.width / [self.scrollView bounds].size.height;
  CGFloat imageWidthHeightRatio = self.image.size.width / self.image.size.height;
  
  CGFloat zoomRectWidth;
  CGFloat zoomRectHeight;
  
  // Check which dimension of the photo needs to fit the screen.
  // If the screen's width/height ratio is smaller then the image's, setting the zoom-rect's
  // height to the image's height assures us that no empty space will be displayed.
  // Otherwise, the zoom-rect's width need to be set to the image's width.
  if(screenWidthHeightRatio < imageWidthHeightRatio) {
    zoomRectWidth = self.image.size.height*screenWidthHeightRatio;
    zoomRectHeight = self.image.size.height;
  } else {
    zoomRectWidth = self.image.size.width;
    zoomRectHeight = self.image.size.width / screenWidthHeightRatio;
  }
  
  // Set the zoom-rect's  position so as to frame the center of the image.
  CGFloat zoomRectX = self.image.size.width/2 - zoomRectWidth/2;
  CGFloat zoomRectY = self.image.size.height/2 - zoomRectHeight/2;
  
  CGRect zoomRect = CGRectMake(zoomRectX, zoomRectY, zoomRectWidth, zoomRectHeight);
  [self.scrollView zoomToRect:zoomRect animated:NO];
}

#pragma mark -
#pragma mark UIScrollViewDelegate
#pragma mark -

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
  return self.imageView;
}

#pragma mark -
#pragma mark Setting the Image from the Image's URL
#pragma mark -

- (void)setImageURL:(NSURL *)imageURL
{
  _imageURL = imageURL;
  [self startDownloadingImage];
}

- (void)startDownloadingImage
{
  self.image = nil;
  
  if (self.imageURL)
  {
    [self.spinner startAnimating];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDownloadTask *task =
    [session downloadTaskWithRequest:request
                   completionHandler:^(NSURL *localfile, NSURLResponse *response, NSError *error) {
                     if (!error) {
                       if ([request.URL isEqual:self.imageURL]) {
                         UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];
                         dispatch_async(dispatch_get_main_queue(), ^{ self.image = image; });
                       }
                     }
                   }];
    [task resume];
  }
}

#pragma mark -
#pragma mark UISplitViewControllerDelegate
#pragma mark -

// this section added during Shutterbug demo

- (void)awakeFromNib
{
  self.splitViewController.delegate = self;
}

- (BOOL)splitViewController:(UISplitViewController *)svc
   shouldHideViewController:(UIViewController *)vc
              inOrientation:(UIInterfaceOrientation)orientation
{
  return UIInterfaceOrientationIsPortrait(orientation);
}

- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc
{
  barButtonItem.title = aViewController.title;
  self.navigationItem.leftBarButtonItem = barButtonItem;
}

- (void)splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
  self.navigationItem.leftBarButtonItem = nil;
}

@end
