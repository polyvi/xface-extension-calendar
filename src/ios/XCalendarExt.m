
/*
 Copyright 2012-2013, Polyvi Inc. (http://polyvi.github.io/openxface)
 This program is distributed under the terms of the GNU General Public License.

 This file is part of xFace.

 xFace is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 xFace is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with xFace.  If not, see <http://www.gnu.org/licenses/>.
 */

//
//  XCalendarExt.m
//  xFaceLib
//
//
#import "XCalendarExt.h"
#import "XCalendarExt_Privates.h"

#import <Cordova/CDVAvailability.h>
#import <Cordova/CDVInvokedUrlCommand.h>
#import <Cordova/CDVPluginResult.h>
#import <Cordova/NSArray+Comparisons.h>
#import <Cordova/CDVDebug.h>

#define VIEW_DEFAULT_WIDTH          320
#define VIEW_DEFAULT_HEIGHT         480
#define TOOLBAR_HEIGHT              44
#define POPOVER_CONTENT_WIDTH       320
#define POPOVER_CONTENT_HEIGHT      244


@implementation XCalendarExt

@synthesize popoverController;

- (void) getTime:(CDVInvokedUrlCommand*)command
{
    callbackId = command.callbackId;
    [self showDatePikcer];
    [datePicker setDatePickerMode:UIDatePickerModeTime];
    [datePicker setDate:[NSDate date]];
}

- (void) getDate:(CDVInvokedUrlCommand*)command
{
    callbackId = command.callbackId;
    [self showDatePikcer];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker setDate:[NSDate date]];
}

- (void)dateChanged:(id)sender
{
    NSDate *date = ((UIDatePicker*)sender).date;
    DLog(@"dateChanged:%@", date);
}

- (void)doCancelClick:(id)sender
{
    //取消 datePickerView
    if (popoverController)
    {
        [popoverController dismissPopoverAnimated:YES];
        popoverController.delegate = nil;
    }

    if (action)
    {
        [action dismissWithClickedButtonIndex:0 animated:YES];
    }

    DLog(@"datepicker canceled !!");
    CDVPluginResult *result = [CDVPluginResult resultWithStatus: CDVCommandStatus_NO_RESULT];
    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)doDoneClick:(id)sender
{
    //取消datePickerView 把设置好的时间返回JS端
    if (popoverController)
    {
        [popoverController dismissPopoverAnimated:YES];
        popoverController.delegate = nil;
    }

    if (action)
    {
        [action dismissWithClickedButtonIndex:1 animated:YES];
    }

    NSDate *selected = [datePicker date];
    DLog(@"you selected date:%@", selected);

    CDVPluginResult *result = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsDictionary:
                                [self getDateComponentsFrom:selected]];
    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

-(NSDictionary*) getDateComponentsFrom:(NSDate*)date
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit | NSMinuteCalendarUnit;
    NSDateComponents *dd = [cal components:unitFlags fromDate:date];

    NSDictionary *dateComponents = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSString stringWithFormat:@"%d", [dd year]], @"year",
                                   [NSString stringWithFormat:@"%d", [dd month]], @"month",
                                   [NSString stringWithFormat:@"%d", [dd day]], @"day",
                                   [NSString stringWithFormat:@"%d", [dd hour]], @"hour",
                                   [NSString stringWithFormat:@"%d", [dd minute]], @"minute",
                                   nil];
    return dateComponents;
}

- (void)createDatePickerView
{
    datePickerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_DEFAULT_WIDTH, VIEW_DEFAULT_HEIGHT)];
    datePickerView.backgroundColor = [UIColor whiteColor];

    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, TOOLBAR_HEIGHT, 0.0, 0.0)];
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];

    UIToolbar *datePickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, VIEW_DEFAULT_WIDTH, TOOLBAR_HEIGHT)];
    datePickerToolbar.barStyle = UIBarStyleBlackOpaque;

    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *btnFlexibleSpace = [[UIBarButtonItem alloc]
                                         initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                         target:self action:nil];
    [barItems addObject:btnFlexibleSpace];

    UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                  target:self
                                  action:@selector(doCancelClick:)];
    [barItems addObject:btnCancel];

    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                target:self
                                action:@selector(doDoneClick:)];

    [barItems addObject:btnDone];
    [datePickerToolbar setItems:barItems animated:YES];

    [datePickerView addSubview: datePickerToolbar];
    [datePickerView addSubview: datePicker];
}

- (void)showDatePikcer
{
    if(CDV_IsIPad())
    {
        //iPad
        if (nil == popoverController)
        {
            [self createDatePickerView];
            UIViewController *popoverContent = [[UIViewController alloc] init];
            popoverContent.view = datePickerView;
            popoverContent.contentSizeForViewInPopover = CGSizeMake(POPOVER_CONTENT_WIDTH, POPOVER_CONTENT_HEIGHT);
            popoverController = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
        }
        [self.popoverController presentPopoverFromRect:CGRectMake(0,0,VIEW_DEFAULT_WIDTH,VIEW_DEFAULT_HEIGHT)
                                                inView:[self.viewController.view superview]
                              permittedArrowDirections:UIPopoverArrowDirectionAny
                                              animated:YES];
    }
    else
    {
        //iphone
        if (nil == action)
        {
            [self createDatePickerView];
            action = [[UIActionSheet alloc] initWithTitle:@""
                                                 delegate:nil
                                        cancelButtonTitle:nil
                                   destructiveButtonTitle:nil
                                        otherButtonTitles:nil];
            [action addSubview:datePickerView];
        }

        UIWindow* appWindow = [self.viewController.view window];
        [action showInView: appWindow];
        [action setBounds:CGRectMake(0, 0, VIEW_DEFAULT_WIDTH, VIEW_DEFAULT_HEIGHT)];
    }
}

@end
