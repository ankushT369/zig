const std = @import("std");

pub fn build(b: *std.Build) void {
    const test_step = b.step("test", "Test it");
    b.default_step = test_step;

    const test_artifact = b.addTest(.{ .root_module = b.createModule(.{
        .root_source_file = b.path("main.zig"),
        .target = b.graph.host,
    }) });
    test_artifact.root_module.addIncludePath(b.path("a_directory"));

    // TODO: actually check the output
    _ = test_artifact.getEmittedBin();

    test_step.dependOn(&test_artifact.step);
}
