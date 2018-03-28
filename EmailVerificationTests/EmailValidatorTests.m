//
//  EmailValidatorTests.m
//  EmailVerificationTests
//
//  Created by Nikita Titov on 28/03/2018.
//  Copyright © 2018 N. M. Titov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EmailValidator.h"

@interface EmailValidatorTests : XCTestCase

@property (strong, nonatomic) EmailValidator *validator;

@end

@implementation EmailValidatorTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.validator = [[EmailValidator alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
