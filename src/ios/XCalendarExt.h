
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
//  XCalendarExt.h
//  xFaceLib
//
//

#import <Cordova/CDVPlugin.h>

@interface XCalendarExt : CDVPlugin
{
}

/**
    初始化时间控件显示的时间并通过时间控件获取系统的时间.
    @param command.arguments
    - 0 hour 初始设置时间控件显示的小时 (iOS 不支持设置初始时间，默认为系统当前时间)
    - 1 minute 初始设置时间控件显示的分钟
 */
- (void) getTime:(CDVInvokedUrlCommand*)command;

/**
    初始化日期控件显示的日期通过日期控件获取系统的日期.
    @param command.arguments
    - 0 year 初始设置日期控件显示的年份 (iOS 不支持设置初始时间，默认为系统当前时间)
    - 1 month 初始设置日期控件显示的月份
    - 2 day 初始设置日期控件显示的天
 */
- (void) getDate:(CDVInvokedUrlCommand*)command;

@end
