const testing = @import("std").testing;

const root = @import("tree-sitter-zig");
const Language = opaque {};
const Parser = opaque {};

extern fn ts_parser_new() *Parser;
extern fn ts_parser_delete(parser: *Parser) void;
extern fn ts_parser_set_language(parser: *Parser, language: *const Language) bool;
extern fn ts_parser_language(parser: *const Parser) ?*const Language;
extern fn ts_language_delete(language: *const Language) void;

test "can load grammar" {
    const parser = ts_parser_new();
    defer ts_parser_delete(parser);

    const lang: *const Language = @ptrCast(root.language());
    defer ts_language_delete(lang);

    try testing.expect(ts_parser_set_language(parser, lang));
    try testing.expectEqual(lang, ts_parser_language(parser));
}
