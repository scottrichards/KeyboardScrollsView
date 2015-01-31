//
//  ScrollView+Utilities.h
//  MedWebConsult
//
//  Created by Eric Herrmann on 8/18/11.
//  Copyright 2011 Sofi Software LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ScrollView_Utilities)

- (void) scrollFieldIntoView:(UIView *)view rootView:(UIView *) rootView keyboardSize:(CGSize) keyboardSize scrollView:(UIScrollView *) scrollView;
- (CGSize) insetScrollViewWhenKeyboardWasShown:(NSNotification*) aNotification scrollView:(UIScrollView *) scrollView;
- (void) restoreScrollViewWhenKeyboardWillBeHidden:(NSNotification*)aNotification scrollView:(UIScrollView *) scrollView;

@end
