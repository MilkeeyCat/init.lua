return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local parser_config = require("nvim-treesitter.parsers")

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
    end,
    init = function()
        local ensure_installed = {
            "vimdoc",
            "javascript",
            "typescript",
            "c",
            "lua",
            "rust",
            "gitcommit",
        }
        local already_installed = require("nvim-treesitter.config").get_installed()
        local parsers_to_install = vim.iter(ensure_installed)
            :filter(function(parser)
                return not vim.tbl_contains(already_installed, parser)
            end)
            :totable()

        require("nvim-treesitter").install(parsers_to_install)
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                pcall(vim.treesitter.start)
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end
}
