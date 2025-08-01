const std = @import("std");

pub fn panic(message: []const u8, stack_trace: ?*std.builtin.StackTrace, _: ?usize) noreturn {
    _ = stack_trace;
    if (std.mem.eql(u8, message, "integer does not fit in destination type")) {
        std.process.exit(0);
    }
    std.process.exit(1);
}
pub fn main() !void {
    const x = unsigned_cast(-10);
    if (x == 0) return error.Whatever;
    return error.TestFailed;
}
fn unsigned_cast(x: i32) u32 {
    return @intCast(x);
}
// run
// backend=stage2,llvm
// target=x86_64-linux,aarch64-linux
