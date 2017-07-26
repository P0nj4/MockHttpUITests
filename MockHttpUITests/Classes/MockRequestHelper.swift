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

        func isMethod(_ method: String) -> OHHTTPStubsTestBlock {
            return {
                $0.httpMethod == method
            }
        }


        guard let path: String = mockRequestItem.requestPath,
            let responseFile: String = mockRequestItem.responseFileName,
            let statusCode: Int32 = mockRequestItem.responseHTTPCode else {
                return
        }

        let stubDescriptor = stub(condition: isPath(path) && isMethod(mockRequestItem.requestMethod)) { _ in
            if mockRequestItem.removeAfterCalled {
                OHHTTPStubs.removeStub(mockRequestItems[mockRequestItem]!)
            }
            if !responseFile.characters.isEmpty {
                let url = Bundle.main.url(forResource: responseFile, withExtension: "json")
                let data = try! Data(contentsOf: url!)
                return OHHTTPStubsResponse(data: data, statusCode: statusCode, headers: ["Content-Type": "application/json; charset=utf-8"])
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
