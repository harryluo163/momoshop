var exports = exports || {};
var ByteBuffer = ByteBuffer || require("bytebuffer");
exports.Long = ByteBuffer.Long;

(function(undefined) {

  function pushTemporaryLength(buffer) {
    var length = buffer.readVarint32();
    var limit = buffer.limit;
    buffer.limit = buffer.offset + length;
    return limit;
  }

  function skipUnknownField(buffer, type) {
    switch (type) {
      case 0: while (buffer.readByte() & 0x80) {} break;
      case 2: buffer.skip(buffer.readVarint32()); break;
      case 5: buffer.skip(4); break;
      case 1: buffer.skip(8); break;
      default: throw new Error("Unimplemented type: " + type);
    }
  }

  function coerceLong(value) {
    if (!(value instanceof ByteBuffer.Long) && "low" in value && "high" in value)
      value = new ByteBuffer.Long(value.low, value.high, value.unsigned);
    return value;
  }

  exports["encodeNodeJS"] = function(message) {
    var buffer = new ByteBuffer(undefined, true);

    // optional int32 type = 1;
    var value = message["type"];
    if (value !== undefined) {
      buffer.writeVarint32(8);
      buffer.writeVarint64(value | 0);
    }

    // optional string id = 2;
    var value = message["id"];
    if (value !== undefined) {
      buffer.writeVarint32(18);
      var nested = new ByteBuffer(undefined, true);
      nested.writeUTF8String(value), buffer.writeVarint32(nested.flip().limit), buffer.append(nested);
    }

    return buffer.flip().toBuffer();
  };

  exports["decodeNodeJS"] = function(buffer) {
    var message = {};

    if (!(buffer instanceof ByteBuffer))
      buffer = new ByteBuffer.fromBinary(buffer, true);

    end_of_message: while (buffer.remaining() > 0) {
      var tag = buffer.readVarint32();

      switch (tag >>> 3) {
      case 0:
        break end_of_message;

      // optional int32 type = 1;
      case 1:
        message["type"] = buffer.readVarint32();
        break;

      // optional string id = 2;
      case 2:
        message["id"] = buffer.readUTF8String(buffer.readVarint32(), "b");
        break;

      default:
        skipUnknownField(buffer, tag & 7);
      }
    }

    return message;
  };

})();
