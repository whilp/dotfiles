workspace(name = "dotfiles")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//3p:repo.bzl", "repo")

#http_archive(
#    name = "bazel_skylib",
#    sha256 = "b18e43a101d620af173b3504faf4204b4ee0b97e1d05679bd0fec90c31a91eb9",
#    strip_prefix = "bazel-skylib-6e2d7e4a75b8ec0c307cf2ff2ca3d837633413ca",
#    urls = ["https://github.com/bazelbuild/bazel-skylib/archive/6e2d7e4a75b8ec0c307cf2ff2ca3d837633413ca.tar.gz"],
#)

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "35c585261362a96b1fe777a7c4c41252b22fd404f24483e1c48b15d7eb2b55a5",
    strip_prefix = "rules_docker-4282829a554058401f7ff63004c8870c8d35e29c",
    urls = ["https://github.com/bazelbuild/rules_docker/archive/4282829a554058401f7ff63004c8870c8d35e29c.tar.gz"],
)

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "875728865fd3d9e1f8008fd5afbaac361363fa0d8816de6abd4a0db2baa35a4a",
    strip_prefix = "rules_go-1cd1a773e6cc32f14d20ded1c0c1b34203354a2a",
    urls = ["https://github.com/bazelbuild/rules_go/archive/1cd1a773e6cc32f14d20ded1c0c1b34203354a2a.tar.gz"],
)

http_archive(
    name = "bazel_gazelle",
    sha256 = "cced089a43ae3e7a72b3aceb23e73b172b6763a8ae20164ec36e27265505b3a5",
    strip_prefix = "bazel-gazelle-bb3efb568f0d252059f064b35030a5afc8da7f7a",
    urls = ["https://github.com/bazelbuild/bazel-gazelle/archive/bb3efb568f0d252059f064b35030a5afc8da7f7a.tar.gz"],
)

http_archive(
    name = "com_github_bazelbuild_buildtools",
    sha256 = "ad7625e1226f1ccd39cae1594b4fe5f1bb938142c3d28e88aaae1635d5e26969",
    strip_prefix = "buildtools-651ea753927b42e601e5d2d40e1700d4a61e6705",
    url = "https://github.com/bazelbuild/buildtools/archive/651ea753927b42e601e5d2d40e1700d4a61e6705.tar.gz",
)

http_archive(
    name = "subpar",
    sha256 = "a694bd35ff4be79a49fbb6e5fd6b1c9083ef05cd752409f5fe349f6d74432fd8",
    strip_prefix = "subpar-07ff5feb7c7b113eea593eb6ec50b51099cf0261",
    urls = ["https://github.com/google/subpar/archive/07ff5feb7c7b113eea593eb6ec50b51099cf0261.tar.gz"],
)

load(
    "@io_bazel_rules_docker//container:container.bzl",
    "container_pull",
    container_repositories = "repositories",
)
load("@io_bazel_rules_go//go:def.bzl", "go_register_toolchains", "go_rules_dependencies")
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")
load("@com_github_bazelbuild_buildtools//buildifier:deps.bzl", "buildifier_dependencies")
#load("@bazel_skylib//lib/versions.bzl", "versions")

repo()

container_repositories()

go_rules_dependencies()

go_register_toolchains()

gazelle_dependencies()

buildifier_dependencies()

container_repositories()

container_pull(
    name = "ubuntu",
    # 18.04
    digest = "sha256:30e04ddada6eb09c12330c7df72cad1573916c7100168c34076808169ff6d805",
    registry = "index.docker.io",
    repository = "library/ubuntu",
)

load("//image:debs.bzl", "image_packages")

image_packages()

load("//image:files.bzl", "image_files")

image_files()

load("//nvim:files.bzl", "nvim_files")

nvim_files()

#versions.check(minimum_bazel_version = "0.17.2")
