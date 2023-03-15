// Code generated by Wire protocol buffer compiler, do not edit.
// Source: app.cash.trifle.api.alpha.SignedData in public.proto
import Foundation
import Wire

/**
 * The signed data object handled by s2dk. This proto is used as a serialization/deserialization
 * mechanism for an otherwise opaque object whose representation is internal to the library only.
 * The purpose of this message is to represent a signed message that contains the client encoded
 * data, certificate chain (includes the signing certificate), signature, and Trifle metadata.
 */
public struct SignedData {

    /**
     * The data which has been signed. This should deserialize to a SigningMessage
     * message after verification.
     */
    public var raw_data: Data?
    /**
     * The actual signature over the associated Data, generated according to
     * the algorithm and private key with the associated certificate.
     */
    public var signature: Data?
    /**
     * The Trifle certificates that include the leaf, intermediate (if any), and root,
     * in the order described.
     *
     * Certificate chain is provided by signer so that the verifier can verify
     * with its root certificate.
     *
     * The leaf certificate embeds the verification (public) key. The certificate must
     * match the certificate of the signed data.
     */
    public var certificates: [Certificate]
    public var unknownFields: Data = .init()

    public init(
        raw_data: Data? = nil,
        signature: Data? = nil,
        certificates: [Certificate] = []
    ) {
        self.raw_data = raw_data
        self.signature = signature
        self.certificates = certificates
    }

}

#if !WIRE_REMOVE_EQUATABLE
extension SignedData : Equatable {
}
#endif

#if !WIRE_REMOVE_HASHABLE
extension SignedData : Hashable {
}
#endif

#if swift(>=5.5)
extension SignedData : Sendable {
}
#endif

extension SignedData : ProtoMessage {
    public static func protoMessageTypeURL() -> String {
        return "type.googleapis.com/app.cash.trifle.api.alpha.SignedData"
    }
}

extension SignedData : Proto2Codable {
    public init(from reader: ProtoReader) throws {
        var raw_data: Data? = nil
        var signature: Data? = nil
        var certificates: [Certificate] = []

        let token = try reader.beginMessage()
        while let tag = try reader.nextTag(token: token) {
            switch tag {
            case 1: raw_data = try reader.decode(Data.self)
            case 2: signature = try reader.decode(Data.self)
            case 3: try reader.decode(into: &certificates)
            default: try reader.readUnknownField(tag: tag)
            }
        }
        self.unknownFields = try reader.endMessage(token: token)

        self.raw_data = raw_data
        self.signature = signature
        self.certificates = certificates
    }

    public func encode(to writer: ProtoWriter) throws {
        try writer.encode(tag: 1, value: self.raw_data)
        try writer.encode(tag: 2, value: self.signature)
        try writer.encode(tag: 3, value: self.certificates)
        try writer.writeUnknownFields(unknownFields)
    }
}

#if !WIRE_REMOVE_CODABLE
extension SignedData : Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringLiteralCodingKeys.self)
        self.raw_data = try container.decodeIfPresent(stringEncoded: Data.self, firstOfKeys: "rawData", "raw_data")
        self.signature = try container.decodeIfPresent(stringEncoded: Data.self, forKey: "signature")
        self.certificates = try container.decodeProtoArray(Certificate.self, forKey: "certificates")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringLiteralCodingKeys.self)
        let preferCamelCase = encoder.protoKeyNameEncodingStrategy == .camelCase
        let includeDefaults = encoder.protoDefaultValuesEncodingStrategy == .include

        try container.encodeIfPresent(stringEncoded: self.raw_data, forKey: preferCamelCase ? "rawData" : "raw_data")
        try container.encodeIfPresent(stringEncoded: self.signature, forKey: "signature")
        if includeDefaults || !self.certificates.isEmpty {
            try container.encodeProtoArray(self.certificates, forKey: "certificates")
        }
    }
}
#endif