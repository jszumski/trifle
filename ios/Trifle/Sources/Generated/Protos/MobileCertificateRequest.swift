// Code generated by Wire protocol buffer compiler, do not edit.
// Source: app.cash.trifle.api.alpha.MobileCertificateRequest in public.proto
import Foundation
import Wire

/**
 * The certificate request object generated by Trifle on mobile clients. This proto is used as a
 * serialization/deserialization mechanism for an otherwise opaque object whose representation is
 * internal to the library only. This primary purpose of this message is to convey the public key
 * portion of the key pair created on a client's device so that an authorization service may then
 * grant the client a certificate.
 */
public struct MobileCertificateRequest {

    /**
     * Version describing the current format of the MobileCertificateRequest.
     * Required.
     */
    @ProtoDefaulted
    public var version: UInt32?
    /**
     * Bytes representing a Certificate Request as specified in the PKCS10 RFC, see
     * https://datatracker.ietf.org/doc/html/rfc5967 for details.
     */
    @ProtoDefaulted
    public var pkcs10_request: Foundation.Data?
    public var unknownFields: UnknownFields = .init()

    public init(configure: (inout Self) -> Swift.Void = { _ in }) {
        configure(&self)
    }

}

#if !WIRE_REMOVE_EQUATABLE
extension MobileCertificateRequest : Equatable {
}
#endif

#if !WIRE_REMOVE_HASHABLE
extension MobileCertificateRequest : Hashable {
}
#endif

extension MobileCertificateRequest : Sendable {
}

extension MobileCertificateRequest : ProtoDefaultedValue {

    public static var defaultedValue: Self {
        .init()
    }
}

extension MobileCertificateRequest : ProtoMessage {

    public static func protoMessageTypeURL() -> String {
        return "type.googleapis.com/app.cash.trifle.api.alpha.MobileCertificateRequest"
    }

}

extension MobileCertificateRequest : Proto2Codable {

    public init(from protoReader: ProtoReader) throws {
        var version: UInt32? = nil
        var pkcs10_request: Foundation.Data? = nil

        let token = try protoReader.beginMessage()
        while let tag = try protoReader.nextTag(token: token) {
            switch tag {
            case 1: version = try protoReader.decode(UInt32.self, encoding: .variable)
            case 2: pkcs10_request = try protoReader.decode(Foundation.Data.self)
            default: try protoReader.readUnknownField(tag: tag)
            }
        }
        self.unknownFields = try protoReader.endMessage(token: token)

        self._version.wrappedValue = version
        self._pkcs10_request.wrappedValue = pkcs10_request
    }

    public func encode(to protoWriter: ProtoWriter) throws {
        try protoWriter.encode(tag: 1, value: self.version, encoding: .variable)
        try protoWriter.encode(tag: 2, value: self.pkcs10_request)
        try protoWriter.writeUnknownFields(unknownFields)
    }

}

#if !WIRE_REMOVE_CODABLE
extension MobileCertificateRequest : Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringLiteralCodingKeys.self)
        self._version.wrappedValue = try container.decodeIfPresent(UInt32.self, forKey: "version")
        self._pkcs10_request.wrappedValue = try container.decodeIfPresent(stringEncoded: Foundation.Data.self, firstOfKeys: "pkcs10Request", "pkcs10_request")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringLiteralCodingKeys.self)
        let preferCamelCase = encoder.protoKeyNameEncodingStrategy == .camelCase

        try container.encodeIfPresent(self.version, forKey: "version")
        try container.encodeIfPresent(stringEncoded: self.pkcs10_request, forKey: preferCamelCase ? "pkcs10Request" : "pkcs10_request")
    }

}
#endif
