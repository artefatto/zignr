const std = @import("std");
var stdout = std.fs.File.stdout().writer(&.{});
const commands = @import("commands.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    const help_message =
        \\Get gitignore templates from command line
        \\
        \\Commands:
        \\
        \\  omit list          prints all avaible gitignore templates to stdout.
        \\  omit <template>    prints the gitignore content to stdout.
        \\
        \\Examples:
        \\
        \\  omit python,lua,zig > .gitignore
        \\  The above command puts the gitignore content of Python, Lua and Zig templates into .gitignore file.
        \\
    ;

    if (args.len != 2) {
        try stdout.interface.print(help_message, .{});
        return;
    }

    if (std.mem.eql(u8, args[1], "list")) {
        try commands.listAvailableLanguages(args);
        return;
    }

    const language = std.mem.sliceTo(args[1], 0);
    try commands.getGitignoreContent(args, language);
}
