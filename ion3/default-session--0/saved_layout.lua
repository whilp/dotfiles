-- This file has been generated by Ion. Do not edit.
return {
    [0] = {
        ["subs"] = {
            [1] = {
                ["type"] = "WIonWS",
                ["name"] = "WIonWS<2>",
                ["switchto"] = true,
                ["split_tree"] = {
                    ["tls"] = 749,
                    ["tl"] = {
                        ["tls"] = 911,
                        ["tl"] = {
                            ["tls"] = 282,
                            ["tl"] = {
                                ["tls"] = 517,
                                ["tl"] = {
                                    ["type"] = "WSplitRegion",
                                    ["regparams"] = {
                                        ["flags"] = 0,
                                        ["type"] = "WFrame",
                                        ["name"] = "im-main",
                                        ["subs"] = {
                                        },
                                        ["frame_style"] = "frame-tiled-ionws",
                                    },
                                },
                                ["dir"] = "vertical",
                                ["brs"] = 232,
                                ["br"] = {
                                    ["type"] = "WSplitRegion",
                                    ["regparams"] = {
                                        ["flags"] = 8,
                                        ["type"] = "WFrame",
                                        ["name"] = "WFrame",
                                        ["subs"] = {
                                        },
                                        ["frame_style"] = "frame-tiled-ionws",
                                        ["saved_h"] = 221,
                                        ["saved_y"] = 547,
                                    },
                                },
                                ["type"] = "WSplitSplit",
                            },
                            ["dir"] = "horizontal",
                            ["brs"] = 629,
                            ["br"] = {
                                ["type"] = "WSplitRegion",
                                ["regparams"] = {
                                    ["flags"] = 0,
                                    ["type"] = "WFrame",
                                    ["name"] = "im-chat",
                                    ["subs"] = {
                                    },
                                    ["frame_style"] = "frame-tiled-ionws",
                                },
                            },
                            ["type"] = "WSplitSplit",
                        },
                        ["dir"] = "horizontal",
                        ["brs"] = 998,
                        ["br"] = {
                            ["type"] = "WSplitRegion",
                            ["regparams"] = {
                                ["flags"] = 0,
                                ["type"] = "WFrame",
                                ["name"] = "web",
                                ["subs"] = {
                                },
                                ["frame_style"] = "frame-tiled-ionws",
                            },
                        },
                        ["type"] = "WSplitFloat",
                    },
                    ["dir"] = "vertical",
                    ["brs"] = 768,
                    ["br"] = {
                        ["type"] = "WSplitRegion",
                        ["regparams"] = {
                            ["flags"] = 0,
                            ["type"] = "WFrame",
                            ["name"] = "term",
                            ["subs"] = {
                                [1] = {
                                    ["type"] = "WClientWin",
                                    ["windowid"] = 8388611,
                                    ["switchto"] = true,
                                    ["checkcode"] = 1,
                                },
                            },
                            ["frame_style"] = "frame-tiled-ionws",
                        },
                    },
                    ["type"] = "WSplitFloat",
                },
            },
            [2] = {
                ["type"] = "WScratchpad",
                ["frame_style"] = "frame-scratchpad",
                ["layer"] = 2,
                ["hidden"] = true,
                ["flags"] = 0,
                ["passive"] = false,
                ["name"] = "WScratchpad",
                ["subs"] = {
                },
                ["geom"] = {
                    ["y"] = 144,
                    ["h"] = 480,
                    ["w"] = 640,
                    ["x"] = 192,
                },
            },
        },
        ["type"] = "WScreen",
        ["name"] = "WScreen",
    },
}

