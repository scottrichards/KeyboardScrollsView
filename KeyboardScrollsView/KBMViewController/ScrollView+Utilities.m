//
//  ScrollView+Utilities.m
//  MedWebConsult
//
//  Created by Eric Herrmann on 8/18/11.
//  Copyright 2011 Sofi Software LLC. All rights reserved.
//

#import "ScrollView+Utilities.h"


// http://developer.apple.com/library/ios/#DOCUMENTATION/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html

@implementation UIViewController (ScrollView_Utilities)

#pragma mark - keyboard


- (void) scrollFieldIntoView:(UIView *)viewToShow rootView:(UIView *) rootView keyboardSize:(CGSize) keyboardSize scrollView:(UIScrollView *) scrollView
{
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = rootView.frame;
    aRect.size.height -= keyboardSize.height;
    if ([viewToShow isKindOfClass:[UITextView class]]) {    // UITextField was automatically scrolling but UITextView's were not so force it to scroll
        NSLog(@"scrollView.contentSize.height: %f",scrollView.contentSize.height);
        NSLog(@"viewToShow.frame.size.height: %f",viewToShow.frame.size.height);
        NSLog(@"viewToShow.frame.origin.y: %f",viewToShow.frame.origin.y);
        [scrollView scrollRectToVisible:viewToShow.frame animated:YES];        
    } else {
        if (!CGRectContainsPoint(aRect, viewToShow.frame.origin) ) {
            [scrollView scrollRectToVisible:viewToShow.frame animated:YES];
        }
    }
}

- (CGSize) insetScrollViewWhenKeyboardWasShown:(NSNotification*) aNotification scrollView:(UIScrollView *) scrollView
{
    NSDictionary* info = [aNotification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height + 2, 0.0);
    scrollView.contentInset = contentInsets;
    CGSize scrollSize = scrollView.contentSize;
    scrollSize.height += keyboardSize.height;
    scrollView.contentSize = scrollSize;
    scrollView.scrollIndicatorInsets = contentInsets;

    // Caller should call scrollFieldIntoView
    return keyboardSize;
}

- (void) restoreScrollViewWhenKeyboardWillBeHidden:(NSNotification*)aNotification scrollView:(UIScrollView *) scrollView
{
    NSDictionary* info = [aNotification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    CGSize scrollSize = scrollView.contentSize;
    scrollSize.height -= keyboardSize.height;
    scrollView.contentSize = scrollSize;
    scrollView.scrollIndicatorInsets = contentInsets;
}



@end
