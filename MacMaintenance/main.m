//
//  main.m
//  MacMaintenance
//
//  Created by Philipp on 15.05.13.
//  Copyright (c) 2013 Mr Maintenance. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, char *argv[])
{
    [[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
    return NSApplicationMain(argc, (const char **)argv);
}