package(default_visibility = ["//visibility:public"])

platform(
    name = "linux",
    constraint_values = [
        "@platforms//os:linux",
    ],
)

platform(
    name = "linux_x86_32",
    constraint_values = [
        "@platforms//cpu:x86_32",
    ],
    parents = [":linux"],
)

platform(
    name = "linux_x86_64",
    constraint_values = [
        "@platforms//cpu:x86_64",
    ],
    parents = [":linux"],
)

platform(
    name = "android",
    constraint_values = [
        "@platforms//os:android",
    ],
)

platform(
    name = "android_arm",
    constraint_values = [
        "@platforms//cpu:arm",
    ],
    parents = [":android"],
)

platform(
    name = "android_aarch64",
    constraint_values = [
        "@platforms//cpu:aarch64",
    ],
    parents = [":android"],
)

platform(
    name = "ios",
    constraint_values = [
        "@platforms//os:ios",
    ],
)

platform(
    name = "macos",
    constraint_values = [
        "@platforms//os:macos",
    ],
)
