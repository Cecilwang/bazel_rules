package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//:linaro_cc_toolchain_config.bzl", "linaro_cc_toolchain_config")

linaro_cc_toolchain_config(
    name = "linaro_%{triple}_cc_toolchain_config",
)

filegroup(
    name = "gcov",
    srcs = [
        "bin/%{triple}-gcov",
    ],
)

filegroup(
    name = "cpp",
    srcs = [
        "bin/%{triple}-cpp",
    ],
)

filegroup(
    name = "gcc",
    srcs = [
        "bin/%{triple}-gcc",
    ],
)

filegroup(
    name = "ar",
    srcs = [
        "bin/%{triple}-ar",
    ],
)

filegroup(
    name = "ld",
    srcs = [
        "bin/%{triple}-ld",
    ],
)

filegroup(
    name = "nm",
    srcs = [
        "bin/%{triple}-nm",
    ],
)

filegroup(
    name = "objcopy",
    srcs = [
        "bin/%{triple}-objcopy",
    ],
)

filegroup(
    name = "objdump",
    srcs = [
        "bin/%{triple}-objdump",
    ],
)

filegroup(
    name = "strip",
    srcs = [
        "bin/%{triple}-strip",
    ],
)

filegroup(
    name = "as",
    srcs = [
        "bin/%{triple}-as",
    ],
)

filegroup(
    name = "compiler_pieces",
    srcs = glob([
        "%{triple}/**",
        "libexec/**",
        "lib/gcc/%{triple}/**",
        "include/**",
    ]),
)

filegroup(
    name = "compiler_components",
    srcs = [
        ":ar",
        ":as",
        ":cpp",
        ":gcc",
        ":ld",
        ":nm",
        ":objcopy",
        ":objdump",
        ":strip",
    ],
)

filegroup(
    name = "all_files",
    srcs = [
        ":compiler_components",
        ":compiler_pieces",
    ],
)

filegroup(
    name = "linker_files",
    srcs = [
        ":ar",
        ":compiler_pieces",
        ":cpp",
        ":gcc",
        ":ld",
    ],
)

filegroup(
    name = "compiler_files",
    srcs = [
        ":as",
        ":compiler_pieces",
        ":cpp",
        ":gcc",
        ":ld",
    ],
)

filegroup(
    name = "empty",
)

cc_toolchain(
    name = "linaro_%{triple}_cc_toolchain",
    all_files = ":all_files",
    compiler_files = ":compiler_files",
    dwp_files = ":empty",
    linker_files = ":linker_files",
    objcopy_files = ":objcopy",
    strip_files = ":strip",
    toolchain_config = ":linaro_%{triple}_cc_toolchain_config",
)

toolchain(
    name = "linaro_%{triple}_toolchain",
    target_compatible_with = [
        "@platforms//os:%{os}",
        "@platforms//cpu:%{cpu}",
    ],
    toolchain = ":linaro_%{triple}_cc_toolchain",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)
