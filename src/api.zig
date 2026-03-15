const std = @import("std");
const http = std.http;
var stdout = std.fs.File.stdout().writer(&.{});

const base_url = "https://donotcommit.com/api/";

const RequestError = error{NotFound};

pub fn request(allocator: std.mem.Allocator, args: [][:0]u8, path: []const u8) ![]u8 {
    var client = http.Client{ .allocator = allocator };
    defer client.deinit();
    var url_buffer: [256]u8 = undefined;
    const url_to_request = std.fmt.bufPrint(&url_buffer, "{s}{s}", .{ base_url, path }) catch |err| {
        return err;
    };

    const uri = try std.Uri.parse(url_to_request);
    const buf = try allocator.alloc(u8, 1024 * 1014 * 4);
    defer allocator.free(buf);

    var req = try client.open(.GET, uri, .{ .server_header_buffer = buf });
    defer req.deinit();

    try req.send();
    try req.finish();
    try req.wait();

    if (req.response.status != .ok) {
        try stdout.interface.print(
            \\Something went wrong. Check you passed only valid languages/templates.
            \\Use: '{s} list' to see the available languages/templates
        , .{args[0]});
        return RequestError.NotFound;
    }

    var rdr = req.reader();
    const body = try rdr.readAllAlloc(allocator, 1024 * 1024 * 4);
    //defer allocator.free(body);

    return body;
}
