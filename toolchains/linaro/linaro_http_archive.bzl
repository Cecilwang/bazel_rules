# Copyright 2019 cecilwang@126.com (Sixue Wang).
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

def _linaro_http_archive_impl(ctx):
    cpu, os, compiler = ctx.attr.triple.split("-")

    ctx.download_and_extract(
        ctx.attr.urls,
        "",
        ctx.attr.sha256,
        ctx.attr.type,
        ctx.attr.strip_prefix,
    )

    ctx.file("WORKSPACE", "workspace(name = \"{name}\")\n".format(name = ctx.name))

    ctx.template(
        "BUILD",
        ctx.attr.build_tpl,
        {
            "%{triple}": ctx.attr.triple,
            "%{cpu}": cpu,
            "%{os}": os,
        },
    )

    ctx.template(
        "linaro_cc_toolchain_config.bzl",
        ctx.attr.crosstool_tpl,
        {
            "%{repo}": ctx.name,
            "%{triple}": ctx.attr.triple,
            "%{cpu}": cpu,
            "%{compiler}": compiler,
            "%{gcc_version}": ctx.attr.gcc_version,
        },
    )

linaro_http_archive = repository_rule(
    attrs = {
        "urls": attr.string_list(mandatory = True),
        "type": attr.string(),
        "strip_prefix": attr.string(),
        "sha256": attr.string(),
        "triple": attr.string(mandatory = True),
        "gcc_version": attr.string(mandatory = True),
        "build_tpl": attr.label(mandatory = True),
        "crosstool_tpl": attr.label(mandatory = True),
    },
    implementation = _linaro_http_archive_impl,
)
