def setup_android():
    native.android_ndk_repository(name = "androidndk")
    native.register_toolchains("@androidndk//:all")
