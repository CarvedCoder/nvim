return {
    "vyfor/cord.nvim",
    build = ":Cord update",
    event = "VeryLazy",
    opts = function()
        return {
            enabled = true,
            log_level = vim.log.levels.OFF,

            -- 🎨 EDITOR CONFIGURATION
            editor = {
                client = "1453017722672648192", -- Your custom Discord application ID
                tooltip = "I use nvim btw",
                --icon = nil, -- Set only if you uploaded a custom editor icon to your Discord app
            },

            -- 🖼️ DISPLAY SETTINGS
            display = {
                theme = "minecraft", -- Options: 'default', 'atom', 'catppuccin', 'minecraft', 'classic'
                flavor = "dark", -- Options: 'dark', 'light', 'accent'
                view = "auto", -- Options: 'full', 'editor', 'asset', 'auto'
                swap_fields = false,
                swap_icons = false,
                show_repository = true,
            },

            -- ⏰ TIMESTAMP CONFIGURATION
            timestamp = {
                enabled = true,
                global = true,
                reset_on_idle = false,
                reset_on_change = false,
                shared = true, -- Set to true to sync timestamps across multiple Neovim instances
            },

            -- 💤 IDLE DETECTION
            idle = {
                enabled = true,
                timeout = 300000, -- 5 minutes in milliseconds
                show_status = true,
                ignore_focus = true,
                unidle_on_focus = true,
                smart_idle = true, -- Shows most recent active instance when one goes idle
                details = "Idling",
                state = nil,
                tooltip = "💤",
                icon = nil,
            },

            -- 📝 CUSTOM TEXT DISPLAYS
            text = {
                workspace = function(opts)
                    return "In " .. (opts.workspace or "workspace")
                end,
                viewing = function(opts)
                    return "Viewing " .. opts.filename
                end,
                editing = function(opts)
                    -- Show cursor position while editing
                    return string.format("Editing %s", opts.filename)
                end,
                file_browser = function(opts)
                    return "Browsing files in " .. opts.name
                end,
                plugin_manager = function(opts)
                    return "Managing plugins in " .. opts.name
                end,
                lsp = function(opts)
                    return "Configuring LSP in " .. opts.name
                end,
                docs = function(opts)
                    return "Reading " .. opts.name
                end,
                vcs = function(opts)
                    return "Committing changes in " .. opts.name
                end,
                notes = function(opts)
                    return "Taking notes in " .. opts.name
                end,
                debug = function(opts)
                    return "Debugging in " .. opts.name
                end,
                test = function(opts)
                    return "Testing in " .. opts.name
                end,
                diagnostics = function(opts)
                    return "Fixing problems in " .. opts.name
                end,
                terminal = function(opts)
                    return "Running commands in " .. opts.name
                end,
                dashboard = "Home",
            },

            -- 🔘 BUTTONS (shown in Discord presence)
            buttons = {
                {
                    label = function(opts)
                        return opts.repo_url and "View Repository" or nil
                    end,
                    url = function(opts)
                        return opts.repo_url
                    end,
                },
            },

            -- 🎯 CUSTOM ASSETS (optional - uncomment and customize as needed)
            -- assets = {
            --     ['.rs'] = {
            --         icon = 'rust',
            --         tooltip = 'Rust',
            --         text = 'Writing in Rust'
            --     },
            -- },

            -- 🔧 VARIABLES (optional - for string templates)
            -- variables = true, -- Enable to use ${variable} syntax in text fields

            -- 🔌 PLUGINS (optional - enable built-in plugins)
            -- plugins = {
            --     'cord.plugins.diagnostics', -- Show LSP diagnostics count
            --     -- ['cord.plugins.diagnostics'] = {
            --     --     scope = 'buffer', -- 'buffer' or 'workspace'
            --     --     severity = { min = vim.diagnostic.severity.WARN },
            --     --     override = true,
            --     -- },
            -- },

            -- 🪝 HOOKS (optional - for advanced customization)
            hooks = {
                -- post_activity = function(opts, activity)
                --     -- Example: Show Neovim version in small tooltip
                --     local version = vim.version()
                --     activity.assets.small_text = string.format('Neovim %s.%s.%s', version.major, version.minor, version.patch)
                -- end,
            },

            -- ⚙️ ADVANCED SETTINGS
            advanced = {
                plugin = {
                    autocmds = true,
                    cursor_update = "on_hold", -- Options: 'on_move', 'on_hold', 'none'
                    match_in_mappings = true,
                },
                server = {
                    update = "fetch", -- Options: 'fetch', 'install', 'build', 'none'
                    pipe_path = nil,
                    executable_path = nil,
                    timeout = 300000,
                },
                discord = {
                    pipe_paths = nil,
                    reconnect = {
                        enabled = true, -- Enable auto-reconnect if Discord connection is lost
                        interval = 5000,
                        initial = true,
                    },
                    sync = {
                        enabled = true,
                        mode = "periodic",
                        interval = 1200,
                        reset_on_update = false,
                        pad = true,
                    },
                },
                workspace = {
                    root_markers = { ".git", ".hg", ".svn" },
                    limit_to_cwd = false,
                },
            },
        }
    end,
}
