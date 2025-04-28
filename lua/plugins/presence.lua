return {
  'andweeb/presence.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- Start of your giant Presence config
    -- =============================================================

    -- Highly customized and whimsical configuration for 'andweeb/presence.nvim'.

    local ok, presence = pcall(require, 'presence')
    if not ok then
      return
    end

    local GitBranch = nil
    local idle = false

    local function update_branch()
      local result = vim.fn.systemlist 'git rev-parse --abbrev-ref HEAD 2>/dev/null'
      if vim.v.shell_error == 0 then
        GitBranch = result[1]
      else
        GitBranch = nil
      end
    end

    local idle_timer = vim.loop.new_timer()
    local idle_timeout = 600000 -- 10 min
    local function reset_idle_timer()
      idle = false
      idle_timer:stop()
      idle_timer:start(idle_timeout, 0, function()
        idle = true
        vim.schedule(function()
          presence:update(nil, true)
        end)
      end)
    end

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'BufEnter', 'BufWinEnter', 'WinEnter' }, {
      callback = reset_idle_timer,
    })

    local file_assets = {
      lua = { text = 'Weaving Lua enchantments in %s', icon = 'lua' },
      py = { text = 'Cultivating Pythonic logic in %s', icon = 'python' },
      c = { text = 'Tinkering under the hood of %s', icon = 'c' },
      rs = { text = 'Forging robust futures in %s', icon = 'rust' },
      go = { text = 'Sailing through channels in %s', icon = 'go' },
      js = { text = 'Orchestrating scripts in %s', icon = 'javascript' },
      ts = { text = 'Scheming with types in %s', icon = 'typescript' },
      markdown = { text = 'Scribing knowledge in %s', icon = 'markdown' },
      md = { text = 'Scribing knowledge in %s', icon = 'markdown' },
      tex = { text = 'Typesetting wonders in %s', icon = 'latex' },
      default = { text = 'Exploring the mysteries of %s', icon = 'file' },
    }

    presence:setup {
      client_id = 'DISCORD_CLIENT_ID',
      auto_update = true,
      neovim_image_text = 'Neovim: weaving creative code fabrics',
      main_image = 'file',
      debounce_timeout = 2,
      enable_line_number = false,
      file_assets = file_assets,
      show_time = true,

      editing_text = function(file_name)
        if idle then
          return ('Daydreaming with %s'):format(file_name)
        end
        local ok_dap, dap = pcall(require, 'dap')
        if ok_dap and dap.session() then
          return ('Debugging %s'):format(file_name)
        end
        local ft = vim.bo.filetype
        local format_str = file_assets[ft] and file_assets[ft].text or file_assets['default'].text
        local status = format_str:format(file_name)
        if GitBranch and GitBranch ~= '' then
          status = status .. (' on branch %s'):format(GitBranch)
        end
        local diags = vim.diagnostic.get(0)
        local err_count, warn_count = 0, 0
        for _, d in ipairs(diags) do
          if d.severity == vim.diagnostic.severity.ERROR then
            err_count = err_count + 1
          elseif d.severity == vim.diagnostic.severity.WARN then
            warn_count = warn_count + 1
          end
        end
        if err_count > 0 or warn_count > 0 then
          status = status .. ('  🐞%d ⚠️%d'):format(err_count, warn_count)
        end
        return status
      end,
      file_explorer_text = function(explorer_name)
        return ('Navigating the %s labyrinth'):format(explorer_name)
      end,
      git_commit_text = 'Committing code changes to version control',
      plugin_manager_text = 'Organizing plugins and magical extensions',
      reading_text = function(file_name)
        local status = ('Reading the scroll of %s'):format(file_name)
        if GitBranch and GitBranch ~= '' then
          status = status .. (' on branch %s'):format(GitBranch)
        end
        return status
      end,
      workspace_text = function(project_name, file_name)
        if GitBranch and GitBranch ~= '' then
          return ('In the realm of %s at branch %s'):format(project_name or 'project', GitBranch)
        end
        return ('Working within %s'):format(project_name or 'the realm')
      end,
    }

    vim.api.nvim_create_autocmd({ 'DirChanged', 'BufEnter', 'BufWinEnter', 'BufReadPost' }, {
      callback = function()
        update_branch()
        presence:update(nil, true)
      end,
    })

    vim.api.nvim_create_autocmd('DiagnosticChanged', {
      callback = function()
        presence:update(nil, true)
      end,
    })

    vim.api.nvim_create_autocmd('FocusGained', {
      callback = function()
        presence:update(nil, true)
      end,
    })

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.notify('🚀 Discord Presence is live and ready to rumble!', vim.log.levels.INFO, { title = 'presence.nvim' })
      end,
    })

    update_branch()

    -- =============================================================
    -- End of Presence config
  end,
}
