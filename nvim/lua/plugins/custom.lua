return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      --   on_highlights = function(hl, _)
      --     -- Link the treesitter capture for Python docstrings to the Comment group.
      --     hl["@string.documentation.python"] = { link = "Comment" }
      --   end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "tokyonight" },
  },
  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = true,
      columns = {
        "icon",
      },
      keymaps = {
        ["<C-h>"] = false,
      },
      view_options = {
        show_hidden = true,
      },
    },
    -- Optional dependencies
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },
  {
    "tpope/vim-obsession",
  },
  {
    "microsoft/python-type-stubs",
    cond = false,
  },
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          -- runner = "pytest",
          -- python = ".venv/bin/python",
        },
      },
    },
  },
  {
    "nvim-mini/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          r = ai.gen_spec.treesitter({ a = "@return.outer", i = "@return.inner" }), -- class
          s = ai.gen_spec.treesitter({ a = "@assignment.outer", i = "@assignment.rhs" }), -- class
          h = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }), -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" }, -- digits
          e = { -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          g = LazyVim.mini.ai_buffer, -- buffer
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    -- can check file struct by :InpsectTree
    branch = "main",
    event = "VeryLazy",
    opts = {
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        -- LazyVim extention to create buffer-local keymaps
        keys = {
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
            ["]a"] = "@parameter.inner",
            ["]u"] = "@call.outer",
            ["]s"] = "@assignment.rhs",
            ["]S"] = "@assignment.outer",
            ["]r"] = "@return.inner",
            ["]b"] = "@block.inner",
            -- unsetting keymap lead to error
            -- ]C sometimes cannot be overrided
            -- it is stochastic beavhior
            -- ["]g"] = "@conditional.outer",
            ["]g"] = "@conditional.outer",
            ["]v"] = "@comment.outer",
            ["]l"] = "@loop.outer",
            -- ["]]"] = "@statement.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[a"] = "@parameter.inner",
            ["[u"] = "@call.outer",
            ["[s"] = "@assignment.rhs",
            ["[S"] = "@assignment.outer",
            ["[r"] = "@return.inner",
            ["[b"] = "@block.inner",
            ["[g"] = "@conditional.outer",
            ["[v"] = "@comment.outer",
            ["[l"] = "@loop.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]A"] = "@parameter.inner",
            ["]U"] = "@call.inner",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[A"] = "@parameter.inner",
            ["[U"] = "@call.inner",
          },
        },
      },
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  -- {
  --   "mawkler/demicolon.nvim",
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "nvim-treesitter/nvim-treesitter-textobjects",
  --   },
  --   opts = {},
  -- },
  {
    "ThePrimeagen/99",
    config = function()
      local _99 = require("99")

      -- For logging that is to a file if you wish to trace through requests
      -- for reporting bugs, i would not rely on this, but instead the provided
      -- logging mechanisms within 99.  This is for more debugging purposes
      local cwd = vim.uv.cwd()
      local basename = vim.fs.basename(cwd)
      _99.setup({
        provider = _99.Providers.OpenCodeProvider, -- default: OpenCodeProvider
        model = "openai/gpt-5.5",
        logger = {
          level = _99.DEBUG,
          path = "/tmp/" .. basename .. ".99.debug",
          print_on_error = true,
        },
        -- When setting this to something that is not inside the CWD tools
        -- such as claude code or opencode will have permission issues
        -- and generation will fail refer to tool documentation to resolve
        -- https://opencode.ai/docs/permissions/#external-directories
        -- https://code.claude.com/docs/en/permissions#read-and-edit
        tmp_dir = "./tmp",

        --- Completions: #rules and @files in the prompt buffer
        completion = {
          -- I am going to disable these until i understand the
          -- problem better.  Inside of cursor rules there is also
          -- application rules, which means i need to apply these
          -- differently
          -- cursor_rules = "<custom path to cursor rules>"

          --- A list of folders where you have your own SKILL.md
          --- Expected format:
          --- /path/to/dir/<skill_name>/SKILL.md
          ---
          --- Example:
          --- Input Path:
          --- "scratch/custom_rules/"
          ---
          --- Output Rules:
          --- {path = "scratch/custom_rules/vim/SKILL.md", name = "vim"},
          --- ... the other rules in that dir ...
          ---
          custom_rules = {
            "scratch/custom_rules/",
          },

          --- Configure @file completion (all fields optional, sensible defaults)
          files = {
            -- enabled = true,
            -- max_file_size = 102400,     -- bytes, skip files larger than this
            -- max_files = 5000,            -- cap on total discovered files
            -- exclude = { ".env", ".env.*", "node_modules", ".git", ... },
          },
          --- File Discovery:
          --- - In git repos: Uses `git ls-files` which automatically respects .gitignore
          --- - Non-git repos: Falls back to filesystem scanning with manual excludes
          --- - Both methods apply the configured `exclude` list on top of gitignore

          --- What autocomplete engine to use. Defaults to native (built-in) if not specified.
          source = "native", -- "native" (default), "cmp", or "blink"
        },

        --- WARNING: if you change cwd then this is likely broken
        --- ill likely fix this in a later change
        ---
        --- md_files is a list of files to look for and auto add based on the location
        --- of the originating request.  That means if you are at /foo/bar/baz.lua
        --- the system will automagically look for:
        --- /foo/bar/AGENT.md
        --- /foo/AGENT.md
        --- assuming that /foo is project root (based on cwd)
        md_files = {
          "AGENT.md",
        },
      })

      -- take extra note that i have visual selection only in v mode
      -- technically whatever your last visual selection is, will be used
      -- so i have this set to visual mode so i dont screw up and use an
      -- old visual selection
      --
      -- likely ill add a mode check and assert on required visual mode
      -- so just prepare for it now
      vim.keymap.set("v", "<leader>9v", function()
        _99.visual()
      end)

      --- if you have a request you dont want to make any changes, just cancel it
      vim.keymap.set("n", "<leader>9x", function()
        _99.stop_all_requests()
      end)

      vim.keymap.set("n", "<leader>9s", function()
        _99.search()
      end)

      vim.keymap.set("n", "<leader>9l", function()
        _99.view_logs()
      end)
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "saghen/blink.compat",
    },
    opts = {
      sources = {
        compat = { "emoji" },
      },
    },
  },
  {
    "CRAG666/code_runner.nvim",
    config = true,
    opts = {
      mode = "float",
      float = {
        close_key = "q",
        border = "single",
      },
      filetype = {
        java = {
          "cd $dir &&",
          "javac $fileName &&",
          "java $fileNameWithoutExt",
        },
        python = "python3 -u",
        typescript = "deno run",
        rust = {
          "cd $dir &&",
          "rustc $fileName &&",
          "$dir/$fileNameWithoutExt",
        },
        c = "cd $dir && gcc $fileName -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt",
      },
    },
  },
  {
    "CRAG666/betterTerm.nvim",
    opts = {
      -- your options
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      servers = {
        pyrefly = {
          settings = {
            python = {
              pyrefly = {
                displayTypeErrors = "force-on",
              },
            },
          },
        },
      },
    },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggle", "DiffviewFileHistory" },
    -- keys = {
    --   { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
    --   { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
    -- },
    opts = {},
  },
}
