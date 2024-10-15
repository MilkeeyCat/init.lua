return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        local configs = require("nvim-treesitter.configs")

        vim.filetype.add({
            extension = {
                templ = "templ"
            }
        })
        vim.filetype.add({
            extension = {
                mk = "mk"
            }
        })

        parser_config.meraki = {
            install_info = {
                url = "~/personal/tree-sitter-meraki",
                files = { "src/parser.c" },
                branch = "master",
                generate_requires_npm = false,
                requires_generate_from_grammar = false,
            },
            filetype = "mk",
        }

        configs.setup({
            ensure_installed = {
                "vimdoc",
                "javascript",
                "typescript",
                "c",
                "lua",
                "rust",
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        })
    end,
}
