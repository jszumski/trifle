//
//  TrifleTests.swift
//  Trifle_Tests
//

import Trifle
import XCTest

final class TrifleTests: XCTestCase {

    let tag = "app.cash.trifle.s2dk.keys.digital_signature"

   
    func testInit() throws {
        let trifle = try Trifle(tag: tag)
        XCTAssertNotNil(trifle)
    }

    func testInitEmptyTag() throws {
        XCTAssertThrowsError(try Trifle(tag: ""), "Tag cannot be empty")
    }

    func testGetKeyHandle() throws {
        let trifle = try Trifle(tag: tag)
        let keyHandle = try trifle.generateSigningKeyHandle()
                
        // serialize
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(keyHandle)
        XCTAssertEqual(String(data: jsonData, encoding: .utf8)!, "{\"tag\":\"" + tag + "\"}")

        // de-serialized
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(KeyHandle.self, from: jsonData)
        XCTAssert(type(of: decoded) == type(of: keyHandle))
    }

    
    func testGenerateMobileCertificateRequest() throws {
        let trifle = try Trifle(tag: tag)
        let mobileCertReq = try trifle.generateMobileCertificateRequest()
        
        XCTAssertEqual(mobileCertReq.version, 0)
        XCTAssertNotNil(mobileCertReq.pkcs10_request)
    }
}
