load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//toolchains/linaro:linaro_http_archive.bzl", "linaro_http_archive")

def clean_dep(dep):
    return str(Label(dep))

def setup_android():
    native.android_ndk_repository(name = "androidndk")
    native.register_toolchains("@androidndk//:all")

def setup_linaro():
    linaro_http_archive(
        name = "linaro",
        build_tpl = "//toolchains/linaro:BUILD.tpl",
        crosstool_tpl = "//toolchains/linaro:linaro_cc_toolchain_config.tpl",
        gcc_version = "6.3.1",
        sha256 = "afa98ac8ea20b75e894123c79308a2f7ac7cbcb7e655eb9cc1cacbec23c51ab0",
        strip_prefix = "gcc-linaro-6.3.1-2017.05-x86_64_aarch64-linux-gnu",
        triple = "aarch64-linux-gnu",
        urls = [
            "http://releases.linaro.org/components/toolchain/binaries/6.3-2017.05/aarch64-linux-gnu/gcc-linaro-6.3.1-2017.05-x86_64_aarch64-linux-gnu.tar.xz",
        ],
    )
    native.register_toolchains("@linaro//:all")

def setup_deps():
    http_archive(
        name = "cpplint",
        build_file = clean_dep("//cpplint:cpplint.BUILD"),
        sha256 = "05f879aab5a04307e916e32afb547567d8a44149ddc2f91bf846ce2650ce6d7d",
        strip_prefix = "cpplint-1.4.4",
        urls = [
            "https://github.com/cpplint/cpplint/archive/1.4.4.tar.gz",
        ],
    )
