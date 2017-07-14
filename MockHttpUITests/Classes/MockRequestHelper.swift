//
//  MockRequestHelper.swift
//  Pods
//
//  Created by German Pereyra on 3/30/17.
//
//

import Foundation
import OHHTTPStubs

public class MockRequestHelper {

    private static var mockRequestItems = [MockRequestItem: OHHTTPStubsDescriptor]()

    public class func mockRequest(mockRequestItem: MockRequestItem) {

        guard let path: String = mockRequestItem.requestPath,
            let responseFile: String = mockRequestItem.responseFileName,
            let statusCode: Int32 = mockRequestItem.responseHTTPCode else {
                return
        }

        let stubDescriptor = stub(condition: isPath(path)) { _ in
            if mockRequestItem.removeAfterCalled {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    OHHTTPStubs.removeStub(mockRequestItems[mockRequestItem]!)
                })
            }
            if !responseFile.characters.isEmpty {
                let stubPath = OHPathForFile("\(responseFile).json", self)
                return OHHTTPStubsResponse(fileAtPath: stubPath!, statusCode: statusCode, headers: ["Content-Type": "application/json; charset=utf-8"])
            }
            return OHHTTPStubsResponse(jsonObject: [], statusCode: statusCode, headers: ["Content-Type": "application/json; charset=utf-8"])
        }
        mockRequestItems[mockRequestItem] = stubDescriptor
    }

    public static func applicationDidStart() {
        for arg in ProcessInfo.processInfo.arguments {
            if let mockRequestItem = MockRequestItem(jsonString: arg) {
                MockRequestHelper.mockRequest(mockRequestItem: mockRequestItem)
            }
        }
    }

}
