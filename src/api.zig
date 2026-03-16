const std = @import("std");
const http = std.http;
var stdout = std.fs.File.stdout().writer(&.{});

const base_url = "https://donotcommit.com/api/";

const RequestError = error{NotFound};

pub fn request(allocator: std.mem.Allocator, args: [][:0]u8, path: []const u8) ![]u8 {
    var client = http.Client{ .allocator = allocator };
    defer client.deinit();

    var url_buffer: [256]u8 = undefined;
    const url_to_request = try std.fmt.bufPrint(&url_buffer, "{s}{s}", .{ base_url, path });
    const uri = try std.Uri.parse(url_to_request);

    var req = try client.request(.GET, uri, .{});
    defer req.deinit();

    try req.sendBodiless();

    var redirect_buffer: [1024]u8 = undefined;
    var response = try req.receiveHead(&redirect_buffer);

    if (response.head.status != .ok) {
        try stdout.interface.print(
            \\Something went wrong. Check you passed only valid languages/templates.
            \\Use: '{s} list' to see the available languages/templates
        , .{args[0]});
        return RequestError.NotFound;
    }

    // Got from https://ziggit.dev/t/simple-http-fetch-request/4456/10
    var transfer_buffer: [64]u8 = undefined;
    var decompress: std.http.Decompress = undefined;
    var decompress_buffer: [std.compress.flate.max_window_len]u8 = undefined;
    const response_reader = response.readerDecompressing(&transfer_buffer, &decompress, &decompress_buffer);

    const body = try response_reader.allocRemaining(allocator, .unlimited);
    return body;
}
