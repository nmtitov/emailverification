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

- (void)testKnownEmails {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssertTrue([self.validator evaluate:@"nmtitov@yandex.ru"]);
    XCTAssertTrue([self.validator evaluate:@"nmtitov@yandex.kz"]);
    XCTAssertTrue([self.validator evaluate:@"nmtitov@yandex.by"]);
    XCTAssertTrue([self.validator evaluate:@"nmtitov@yandex.com"]);
    XCTAssertTrue([self.validator evaluate:@"nmtitov@ya.ru"]);
    XCTAssertTrue([self.validator evaluate:@"mail@gmail.com"]);
    XCTAssertTrue([self.validator evaluate:@"mail+alias@gmail.com"]);
    XCTAssertTrue([self.validator evaluate:@"first_name.last_name@gmail.com"]);
    XCTAssertTrue([self.validator evaluate:@"mail2018@gmail.com"]);
    XCTAssertTrue([self.validator evaluate:@"mail@yahoo.com"]);
    XCTAssertTrue([self.validator evaluate:@"mail@bing.com"]);
}

- (void)testInvalidEmails {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssertFalse([self.validator evaluate:nil]);
    XCTAssertFalse([self.validator evaluate:@""]);
    XCTAssertFalse([self.validator evaluate:@"ale&x@gmail"]);
    XCTAssertFalse([self.validator evaluate:@"alex"]);
    XCTAssertFalse([self.validator evaluate:@"@gmail.com"]);
    XCTAssertFalse([self.validator evaluate:@".com"]);
    XCTAssertFalse([self.validator evaluate:@"."]);
}

@end
