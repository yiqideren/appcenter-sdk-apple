// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

#import "AppCenter.h"
#import "MSDataSourceError.h"
#import "MSDataStoreErrors.h"
#import "MSTestFrameworks.h"

@interface MSDataSourceErrorTests : XCTestCase

@end

@implementation MSDataSourceErrorTests

- (void)testInitWithErrorCallsParsingMethod {

  // If
  NSInteger expectedErrorCode = MSHTTPCodesNo500InternalServerError;
  NSDictionary *userInfo = @{@"MSHttpCodeKey" : @(expectedErrorCode)};
  NSError *error = [NSError errorWithDomain:kMSACErrorDomain code:0 userInfo:userInfo];
  id dataSourceErrorMock = OCMClassMock([MSDataSourceError class]);

  // When
  MSDataSourceError *dataSourceError = [[MSDataSourceError alloc] initWithError:error];

  // Then
  OCMVerify([dataSourceErrorMock errorCodeFromError:OCMOCK_ANY]);
  XCTAssertEqual(expectedErrorCode, dataSourceError.errorCode);
  XCTAssertEqualObjects(error, dataSourceError.error);
  [dataSourceErrorMock stopMocking];
}

- (void)testErrorCodeFromErrorParsesCodeFromUserInfo {

  // If
  NSInteger expectedErrorCode = MSHTTPCodesNo500InternalServerError;
  NSDictionary *userInfo = @{@"MSHttpCodeKey" : @(expectedErrorCode)};
  NSError *error = [NSError errorWithDomain:kMSACErrorDomain code:0 userInfo:userInfo];

  // When
  NSInteger actualErrorCode = [MSDataSourceError errorCodeFromError:error];

  // Then
  XCTAssertEqual(expectedErrorCode, actualErrorCode);
}

- (void)testErrorCodeFromErrorReturnsUnknownWhenNoUserInfo {

  // If
  NSInteger expectedErrorCode = MSHTTPCodesNo0XXInvalidUnknown;
  NSError *error = [NSError errorWithDomain:kMSACErrorDomain code:0 userInfo:nil];

  // When
  NSInteger actualErrorCode = [MSDataSourceError errorCodeFromError:error];

  // Then
  XCTAssertEqual(expectedErrorCode, actualErrorCode);
}

@end
